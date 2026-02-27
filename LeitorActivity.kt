package com.leitoruniversalia

import android.os.Bundle
import android.speech.tts.TextToSpeech
import android.widget.Button
import android.widget.EditText
import androidx.appcompat.app.AppCompatActivity
import java.util.*

class LeitorActivity : AppCompatActivity(), TextToSpeech.OnInitListener {

    private lateinit var tts: TextToSpeech
    private lateinit var edtTexto: EditText

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_leitor)

        edtTexto = findViewById(R.id.edtTexto)

        val btnReadText = findViewById<Button>(R.id.btnReadText)
        val btnAudio = findViewById<Button>(R.id.btnAudio)
        val btnSave = findViewById<Button>(R.id.btnSave)
        val btnCopy = findViewById<Button>(R.id.btnCopy)
        val btnImage = findViewById<Button>(R.id.btnImage)

        tts = TextToSpeech(this, this)

        btnReadText.setOnClickListener {
            val texto = edtTexto.text.toString()
            tts.speak(texto, TextToSpeech.QUEUE_FLUSH, null, null)
        }

        btnAudio.setOnClickListener {
            val texto = edtTexto.text.toString()
            tts.speak(texto, TextToSpeech.QUEUE_FLUSH, null, null)
        }
    }

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            tts.language = Locale("pt", "BR")
        }
    }

    override fun onDestroy() {
        tts.stop()
        tts.shutdown()
        super.onDestroy()
    }
}
