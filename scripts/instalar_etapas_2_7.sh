#!/bin/bash
set -e

echo "===================================="
echo " INSTALANDO ETAPAS 2 → 7"
echo " LeitorUniversalIA"
echo "===================================="

PACKAGE="com.leitoruniversalia"

echo "Criando pastas necessárias..."

mkdir -p app/src/main/java/com/leitoruniversalia
mkdir -p app/src/main/res/layout

############################################
# DEPENDÊNCIAS PDF
############################################

echo "Adicionando biblioteca PDF..."

BUILD=app/build.gradle

if ! grep -q "pdfbox" "$BUILD"; then
sed -i '/dependencies {/a\
    implementation "com.tom-roush:pdfbox-android:2.0.27.0"
' $BUILD
fi

############################################
# NOVO LAYOUT
############################################

echo "Criando layout completo..."

cat > app/src/main/res/layout/activity_main.xml <<'EOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout
xmlns:android="http://schemas.android.com/apk/res/android"
android:layout_width="match_parent"
android:layout_height="match_parent"
android:orientation="vertical"
android:padding="20dp">

<EditText
android:id="@+id/editText"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:hint="Digite ou abra um arquivo"/>

<Button
android:id="@+id/buttonOpen"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:text="Abrir arquivo"/>

<Button
android:id="@+id/buttonRead"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:text="Ler texto"/>

<Button
android:id="@+id/buttonPause"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:text="Pausar"/>

<Button
android:id="@+id/buttonStop"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:text="Parar"/>

<SeekBar
android:id="@+id/speedControl"
android:layout_width="match_parent"
android:layout_height="wrap_content"/>

</LinearLayout>
EOF

############################################
# MAIN ACTIVITY COMPLETA
############################################

echo "Criando MainActivity avançada..."

cat > app/src/main/java/com/leitoruniversalia/MainActivity.kt <<'EOF'
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
EOF

############################################
# BUILD
############################################

echo "Limpando build..."
./gradlew clean

echo "Gerando APK..."
./gradlew assembleDebug

echo "===================================="
echo "ETAPAS 2 → 7 INSTALADAS"
echo "===================================="
