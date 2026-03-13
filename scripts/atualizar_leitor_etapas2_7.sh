#!/bin/bash
set -e

echo "======================================"
echo " ATUALIZAÇÃO ETAPAS 2 → 7"
echo " Biblioteca + Histórico + Seleção"
echo "======================================"

mkdir -p app/src/main/java/com/leitoruniversalia
mkdir -p app/src/main/res/layout

############################################
# LAYOUT
############################################

cat > app/src/main/res/layout/activity_main.xml <<'EOF'
<?xml version="1.0" encoding="utf-8"?>

<ScrollView
xmlns:android="http://schemas.android.com/apk/res/android"
android:layout_width="match_parent"
android:layout_height="match_parent">

<LinearLayout
android:orientation="vertical"
android:padding="20dp"
android:layout_width="match_parent"
android:layout_height="wrap_content">

<EditText
android:id="@+id/editText"
android:layout_width="match_parent"
android:layout_height="300dp"
android:gravity="top"
android:hint="Digite ou abra um livro"/>

<Button
android:id="@+id/buttonOpen"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:text="Abrir Livro"/>

<Button
android:id="@+id/buttonRead"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:text="Ler Texto"/>

<Button
android:id="@+id/buttonPause"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:text="Pausar / Continuar"/>

<Button
android:id="@+id/buttonStop"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:text="Parar"/>

<Button
android:id="@+id/buttonClear"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:text="Limpar Texto"/>

<Spinner
android:id="@+id/speedControl"
android:layout_width="match_parent"
android:layout_height="wrap_content"/>

</LinearLayout>
</ScrollView>
EOF

############################################
# MAIN ACTIVITY
############################################

cat > app/src/main/java/com/leitoruniversalia/MainActivity.kt <<'EOF'
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

    private lateinit var tts:TextToSpeech
    private lateinit var editText:EditText

    private var paused=false
    private var lastText=""

    private val PICK_FILE=100

    override fun onCreate(savedInstanceState:Bundle?){

        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        editText=findViewById(R.id.editText)

        val open=findViewById<Button>(R.id.buttonOpen)
        val read=findViewById<Button>(R.id.buttonRead)
        val pause=findViewById<Button>(R.id.buttonPause)
        val stop=findViewById<Button>(R.id.buttonStop)
        val clear=findViewById<Button>(R.id.buttonClear)
        val spinner=findViewById<Spinner>(R.id.speedControl)

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
            intent.type="text/*"
            startActivityForResult(intent,PICK_FILE)

        }

        read.setOnClickListener{

            val start=editText.selectionStart
            val end=editText.selectionEnd

            val text=if(start!=end){
                editText.text.substring(start,end)
            }else{
                editText.text.toString()
            }

            lastText=text
            paused=false

            tts.speak(text,TextToSpeech.QUEUE_FLUSH,null,null)

        }

        pause.setOnClickListener{

            if(paused){

                tts.speak(lastText,TextToSpeech.QUEUE_FLUSH,null,null)
                paused=false

            }else{

                tts.stop()
                paused=true

            }

        }

        stop.setOnClickListener{

            tts.stop()
            paused=false

        }

        clear.setOnClickListener{

            editText.setText("")

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
EOF

############################################
# BUILD
############################################

./gradlew clean
./gradlew assembleDebug --no-daemon

echo "======================================"
echo " ATUALIZAÇÃO CONCLUÍDA"
echo "======================================"
