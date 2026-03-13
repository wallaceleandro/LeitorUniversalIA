#!/bin/bash
set -e

echo "========================================"
echo "INSTALAÇÃO COMPLETA LEITOR UNIVERSAL IA"
echo "ETAPAS 2 → 7"
echo "========================================"

PACKAGE="com.leitoruniversalia"

mkdir -p app/src/main/java/com/leitoruniversalia
mkdir -p app/src/main/res/layout

########################################
# DEPENDÊNCIAS
########################################

BUILD=app/build.gradle

if ! grep -q "pdfbox-android" "$BUILD"; then
sed -i '/dependencies {/a\
    implementation "com.tom-roush:pdfbox-android:2.0.27.0"\
    implementation "org.apache.tika:tika-core:2.9.0"\
    implementation "org.apache.tika:tika-parsers-standard-package:2.9.0"\
    implementation "nl.siegmann.epublib:epublib-core:3.1"
' $BUILD
fi

########################################
# LAYOUT
########################################

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
android:layout_height="wrap_content"
android:hint="Digite texto ou abra arquivo"
android:minHeight="200dp"/>

<Button
android:id="@+id/buttonOpen"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:text="Abrir arquivo"/>

<Button
android:id="@+id/buttonRead"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:text="Ler"/>

<Button
android:id="@+id/buttonPause"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:text="Pausar"/>

<Button
android:id="@+id/buttonResume"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:text="Continuar"/>

<Button
android:id="@+id/buttonStop"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:text="Parar"/>

<Button
android:id="@+id/buttonClear"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:text="Limpar texto"/>

<Button
android:id="@+id/buttonClearHistory"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:text="Limpar histórico"/>

<Spinner
android:id="@+id/speedControl"
android:layout_width="match_parent"
android:layout_height="wrap_content"/>

</LinearLayout>
</ScrollView>
EOF

########################################
# MAIN ACTIVITY
########################################

cat > app/src/main/java/com/leitoruniversalia/MainActivity.kt <<'EOF'
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
EOF

########################################
# BUILD
########################################

echo "Limpando projeto..."
./gradlew clean

echo "Gerando APK..."
./gradlew assembleDebug

echo "========================================"
echo "LEITOR UNIVERSAL INSTALADO"
echo "========================================"
