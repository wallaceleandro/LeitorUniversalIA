package com.leitoruniversalia

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.speech.tts.TextToSpeech
import androidx.appcompat.app.AppCompatActivity
import android.widget.*
import java.io.*
import java.util.*
import com.tom_roush.pdfbox.pdmodel.PDDocument
import com.tom_roush.pdfbox.text.PDFTextStripper
import org.apache.tika.Tika
import nl.siegmann.epublib.epub.EpubReader

class MainActivity : AppCompatActivity(), TextToSpeech.OnInitListener {

    private lateinit var tts: TextToSpeech
    private lateinit var editText: EditText

    private var pausedText:String=""
    private val PICK_FILE=100

    override fun onCreate(savedInstanceState:Bundle?) {

        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        editText=findViewById(R.id.editText)

        val open=findViewById<Button>(R.id.buttonOpen)
        val read=findViewById<Button>(R.id.buttonRead)
        val pause=findViewById<Button>(R.id.buttonPause)
        val resume=findViewById<Button>(R.id.buttonResume)
        val stop=findViewById<Button>(R.id.buttonStop)
        val clear=findViewById<Button>(R.id.buttonClear)
        val clearHistory=findViewById<Button>(R.id.buttonClearHistory)
        val spinner=findViewById<Spinner>(R.id.speedControl)

        tts=TextToSpeech(this,this)

        val speeds=arrayOf("0.5","0.75","1.0","1.25","1.5","2.0")
        spinner.adapter=ArrayAdapter(this,android.R.layout.simple_spinner_dropdown_item,speeds)

        spinner.onItemSelectedListener=object:AdapterView.OnItemSelectedListener{
            override fun onItemSelected(parent:AdapterView<*>?,view:android.view.View?,pos:Int,id:Long){
                val rate=speeds[pos].toFloat()
                tts.setSpeechRate(rate)
            }
            override fun onNothingSelected(parent:AdapterView<*>?){}
        }

        open.setOnClickListener{

            val intent=Intent(Intent.ACTION_GET_CONTENT)
            intent.type="*/*"
            startActivityForResult(intent,PICK_FILE)

        }

        read.setOnClickListener{

            val text=editText.text.toString()
            pausedText=text
            tts.speak(text,TextToSpeech.QUEUE_FLUSH,null,null)

            saveHistory(text)

        }

        pause.setOnClickListener{

            pausedText=editText.text.toString()
            tts.stop()

        }

        resume.setOnClickListener{

            tts.speak(pausedText,TextToSpeech.QUEUE_FLUSH,null,null)

        }

        stop.setOnClickListener{

            tts.stop()

        }

        clear.setOnClickListener{

            editText.setText("")

        }

        clearHistory.setOnClickListener{

            getSharedPreferences("history",MODE_PRIVATE).edit().clear().apply()

        }

    }

    override fun onActivityResult(requestCode:Int,resultCode:Int,data:Intent?){

        super.onActivityResult(requestCode,resultCode,data)

        if(requestCode==PICK_FILE && resultCode==Activity.RESULT_OK){

            try{

                val uri=data!!.data!!
                val input=contentResolver.openInputStream(uri)

                val name=uri.toString().lowercase()

                var text=""

                if(name.endsWith(".pdf")){

                    val doc=PDDocument.load(input)
                    val stripper=PDFTextStripper()
                    text=stripper.getText(doc)
                    doc.close()

                }else if(name.endsWith(".epub")){

                    val book=EpubReader().readEpub(input)
                    val builder=StringBuilder()

                    book.contents.forEach{

                        builder.append(String(it.data))

                    }

                    text=builder.toString()

                }else{

                    val tika=Tika()
                    text=tika.parseToString(input)

                }

                editText.setText(text)

            }catch(e:Exception){

                Toast.makeText(this,"Erro ao abrir arquivo",Toast.LENGTH_LONG).show()

            }

        }

    }

    private fun saveHistory(text:String){

        val prefs=getSharedPreferences("history",MODE_PRIVATE)
        prefs.edit().putString("last",text).apply()

    }

    override fun onInit(status:Int){

        if(status==TextToSpeech.SUCCESS){

            tts.language=Locale("pt","BR")

        }

    }

    override fun onDestroy(){

        if(::tts.isInitialized){

            tts.stop()
            tts.shutdown()

        }

        super.onDestroy()

    }

}
