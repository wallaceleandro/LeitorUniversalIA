#!/bin/bash
set -e

echo "======================================"
echo "RECRIANDO MAINACTIVITY LIMPA"
echo "======================================"

FILE=app/src/main/java/com/leitoruniversalia/MainActivity.kt

cat > $FILE << 'EOF'
package com.leitoruniversalia

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.speech.tts.TextToSpeech
import android.widget.*
import androidx.appcompat.app.AppCompatActivity
import java.util.*

class MainActivity : AppCompatActivity(), TextToSpeech.OnInitListener {

    private lateinit var editText: EditText
    private lateinit var tts: TextToSpeech

    private var textoAtual:String=""
    private var posicao:Int=0
    private var pausado=false

    private val PICK_FILE = 100

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_main)

        editText = findViewById(R.id.editText)

        val btnLer:Button = findViewById(R.id.btnLer)
        val btnPausar:Button = findViewById(R.id.btnPausar)
        val btnContinuar:Button = findViewById(R.id.btnContinuar)
        val btnParar:Button = findViewById(R.id.btnParar)
        val btnAbrir:Button = findViewById(R.id.btnAbrir)

        tts = TextToSpeech(this,this)

        btnLer.setOnClickListener{

            textoAtual = editText.text.toString()

            if(textoAtual.isNotEmpty()){

                posicao = 0
                pausado=false

                val texto = textoAtual.substring(posicao)

                tts.speak(texto,TextToSpeech.QUEUE_FLUSH,null,null)

            }

        }

        btnPausar.setOnClickListener{

            if(tts.isSpeaking){

                pausado=true
                tts.stop()

                posicao = editText.selectionStart

            }

        }

        btnContinuar.setOnClickListener{

            if(pausado){

                val texto = textoAtual.substring(posicao)

                tts.speak(texto,TextToSpeech.QUEUE_FLUSH,null,null)

                pausado=false

            }

        }

        btnParar.setOnClickListener{

            tts.stop()
            pausado=false
            posicao=0

        }

        btnAbrir.setOnClickListener{

            val intent = Intent(Intent.ACTION_GET_CONTENT)
            intent.type="*/*"
            startActivityForResult(intent,PICK_FILE)

        }

    }

    override fun onInit(status:Int){

        if(status==TextToSpeech.SUCCESS){

            tts.language=Locale("pt","BR")

        }

    }

    override fun onActivityResult(requestCode:Int,resultCode:Int,data:Intent?){
        super.onActivityResult(requestCode,resultCode,data)

        if(requestCode==PICK_FILE && resultCode==Activity.RESULT_OK){

            val uri = data?.data

            val input = contentResolver.openInputStream(uri!!)
            val texto = input!!.bufferedReader().use{it.readText()}

            editText.setText(texto)

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
EOF

echo "MainActivity recriada."

echo "Limpando projeto..."
./gradlew clean

echo "Compilando..."
./gradlew assembleDebug --no-daemon

echo "======================================"
echo "APP REPARADO"
echo "======================================"
