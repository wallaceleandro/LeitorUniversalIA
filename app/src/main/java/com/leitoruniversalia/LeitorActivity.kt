package com.leitoruniversalia

import android.os.Bundle
import android.speech.tts.TextToSpeech
import android.widget.Button
import android.widget.EditText
import androidx.appcompat.app.AppCompatActivity
import java.util.*

class LeitorActivity : AppCompatActivity(), TextToSpeech.OnInitListener {

    private lateinit var tts: TextToSpeech
    private lateinit var editText: EditText

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_leitor)

        editText = findViewById(R.id.editText)

        val btnReadText = findViewById<Button>(R.id.btnReadText)
        val btnAudio = findViewById<Button>(R.id.btnAudio)

        tts = TextToSpeech(this, this)

        btnReadText.setOnClickListener {
            falarTexto()
        }

        btnAudio.setOnClickListener {
            falarTexto()
        }
    }

    private fun falarTexto() {
        val texto = editText.text.toString()
        if (texto.isNotEmpty()) {
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
