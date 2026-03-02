package com.leitoruniversalia.leitor

import android.os.Bundle
import android.speech.tts.TextToSpeech
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.leitoruniversalia.R
import java.util.Locale

class LeitorActivity : AppCompatActivity(), TextToSpeech.OnInitListener {

    private lateinit var tts: TextToSpeech
    private lateinit var editText: EditText
    private lateinit var statusVoice: TextView
    private var ttsReady = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_leitor)

        editText = findViewById(R.id.editText)
        statusVoice = findViewById(R.id.statusVoice)

        val btnPlay = findViewById<Button>(R.id.btnPlay)
        val btnStop = findViewById<Button>(R.id.btnStop)

        tts = TextToSpeech(this, this)

        btnPlay.setOnClickListener {
            if (!ttsReady) {
                statusVoice.text = "Aguardando inicialização..."
                return@setOnClickListener
            }

            val text = editText.text.toString()

            if (text.isNotBlank()) {
                tts.speak(text, TextToSpeech.QUEUE_FLUSH, null, null)
                statusVoice.text = "Status: Falando..."
            } else {
                statusVoice.text = "Digite algum texto primeiro."
            }
        }

        btnStop.setOnClickListener {
            if (ttsReady) {
                tts.stop()
                statusVoice.text = "Status: Parado"
            }
        }
    }

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            val result = tts.setLanguage(Locale("pt", "BR"))
            if (result != TextToSpeech.LANG_MISSING_DATA &&
                result != TextToSpeech.LANG_NOT_SUPPORTED) {
                ttsReady = true
                statusVoice.text = "Pronto para falar."
            } else {
                statusVoice.text = "Idioma não suportado."
            }
        } else {
            statusVoice.text = "Erro ao iniciar voz."
        }
    }

    override fun onDestroy() {
        if (::tts.isInitialized) {
            tts.stop()
            tts.shutdown()
        }
        super.onDestroy()
    }
}
