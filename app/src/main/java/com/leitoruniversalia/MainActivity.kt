package com.leitoruniversalia

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.speech.tts.TextToSpeech
import androidx.appcompat.app.AppCompatActivity
import android.widget.*
import java.io.*
import java.util.*

class MainActivity : AppCompatActivity(), TextToSpeech.OnInitListener {
    private var leituraPosicao:Int=0
    private var textoAtual:String=""




    private lateinit var tts:TextToSpeech
    private lateinit var editText:EditText

    private var paused=false
    private var lastText=""

    private val PICK_FILE=100

    override fun onCreate(savedInstanceState:Bundle?){

        super.onCreate(savedInstanceState)

prefs=getSharedPreferences("books",MODE_PRIVATE)

        setContentView(R.layout.activity_main)

        editText=findViewById(R.id.editText)
        if(textoSalvo!!.isNotEmpty()){
            editText.setText(textoSalvo)
        }


        val open=findViewById<Button>(R.id.buttonOpen)
        val read=findViewById<Button>(R.id.buttonRead)
        val pause=findViewById<Button>(R.id.buttonPause)
        val stop=findViewById<Button>(R.id.buttonStop)
        val clear=findViewById<Button>(R.id.buttonClear)
        val spinner=findViewById<Spinner>(R.id.speedControl)
val library=findViewById<Button>(R.id.buttonLibrary)
library.setOnClickListener{
startActivity(Intent(this,LibraryActivity::class.java))
}


        tts=TextToSpeech(this,this)

        val speeds=arrayOf("0.5","0.75","1.0","1.25","1.5","2.0")

        spinner.adapter=ArrayAdapter(this,android.R.layout.simple_spinner_dropdown_item,speeds)

        spinner.onItemSelectedListener=object:AdapterView.OnItemSelectedListener{

            override fun onItemSelected(parent:AdapterView<*>?,view:android.view.View?,pos:Int,id:Long){
                tts.setSpeechRate(speeds[pos].toFloat())
            }

            override fun onNothingSelected(parent:AdapterView<*>?) {}
        }

        open.setOnClickListener{

            val intent=Intent(Intent.ACTION_GET_CONTENT)
            intent.type="*/*"
intent.addCategory(Intent.CATEGORY_OPENABLE)
            startActivityForResult(intent,PICK_FILE)

        }

        read.setOnClickListener{
            textoAtual = editText.text.toString()
            leituraPosicao = editText.selectionStart
            val texto = textoAtual.substring(leituraPosicao)
            tts.speak(texto,TextToSpeech.QUEUE_FLUSH,null,null)
        }

                editText.text.substring(start,end)
            }else{
                editText.text.toString()
            }

            lastText=text
            paused=false

            tts.speak(text,TextToSpeech.QUEUE_FLUSH,null,null)

        }

        pause.setOnClickListener{
            leituraPosicao = editText.selectionStart
            tts.stop()
        }


            }else{

                tts.stop()
            val pos = editText.selectionStart

                paused=true

            }

        }

        stop.setOnClickListener{

            tts.stop()
            val pos = editText.selectionStart

            paused=false

        }

        clear.setOnClickListener{

            editText.setText("")
prefs.edit().putString(uri.toString(),uri.toString()).apply()


        }

    }

    override fun onActivityResult(requestCode:Int,resultCode:Int,data:Intent?){

        super.onActivityResult(requestCode,resultCode,data)

        if(requestCode==PICK_FILE && resultCode==Activity.RESULT_OK){

            try{

                val uri=data!!.data!!
                val input=contentResolver.openInputStream(uri)

                val reader=BufferedReader(InputStreamReader(input))

                editText.setText(reader.readText())
prefs.edit().putString(uri.toString(),uri.toString()).apply()


            }catch(e:Exception){

                Toast.makeText(this,"Erro ao abrir arquivo",Toast.LENGTH_LONG).show()

            }

        }

    }

    override fun onInit(status:Int){

        if(status==TextToSpeech.SUCCESS){
            tts.language=Locale("pt","BR")
        }

    }

}
