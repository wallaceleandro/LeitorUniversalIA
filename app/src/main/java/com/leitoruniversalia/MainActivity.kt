package com.leitoruniversalia

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.speech.tts.TextToSpeech
import androidx.appcompat.app.AppCompatActivity
import android.widget.*
import java.io.BufferedReader
import java.io.InputStreamReader
import java.util.*

class MainActivity : AppCompatActivity(), TextToSpeech.OnInitListener {

    private lateinit var tts: TextToSpeech
    private lateinit var editText: EditText

    private val PICK_FILE = 100

    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        editText = findViewById(R.id.editText)

        val open = findViewById<Button>(R.id.buttonOpen)
        val read = findViewById<Button>(R.id.buttonRead)
        val pause = findViewById<Button>(R.id.buttonPause)
        val stop = findViewById<Button>(R.id.buttonStop)
        val speed = findViewById<SeekBar>(R.id.speedControl)

        tts = TextToSpeech(this,this)

        open.setOnClickListener {

            val intent = Intent(Intent.ACTION_GET_CONTENT)
            intent.type="*/*"
            startActivityForResult(intent,PICK_FILE)

        }

        read.setOnClickListener {

            val text = editText.text.toString()
            tts.speak(text,TextToSpeech.QUEUE_FLUSH,null,null)

        }

        stop.setOnClickListener {

            tts.stop()

        }

        speed.max = 10
        speed.progress = 5

        speed.setOnSeekBarChangeListener(object:SeekBar.OnSeekBarChangeListener{

            override fun onProgressChanged(seekBar:SeekBar?,value:Int,fromUser:Boolean){

                val rate = value / 5.0f
                tts.setSpeechRate(rate)

            }

            override fun onStartTrackingTouch(seekBar:SeekBar?){}
            override fun onStopTrackingTouch(seekBar:SeekBar?){}

        })

    }

    override fun onActivityResult(requestCode:Int,resultCode:Int,data:Intent?){

        super.onActivityResult(requestCode,resultCode,data)

        if(requestCode==PICK_FILE && resultCode==Activity.RESULT_OK){

            val uri:Uri? = data?.data

            val input = contentResolver.openInputStream(uri!!)
            val reader = BufferedReader(InputStreamReader(input))

            val text = reader.readText()

            editText.setText(text)

        }

    }

    override fun onInit(status:Int){

        if(status==TextToSpeech.SUCCESS){

            tts.language = Locale("pt","BR")

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
