package com.leitoruniversalia

import android.os.Bundle
import android.speech.tts.TextToSpeech
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import java.util.*

class LeitorActivity : AppCompatActivity(), TextToSpeech.OnInitListener {

    private lateinit var editText: EditText
    private lateinit var btnReadText: Button
    private lateinit var tts: TextToSpeech

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_leitor) // Certifique-se que o XML é activity_leitor.xml

        // Referências aos elementos do layout
        editText = findViewById(R.id.editText)
        btnReadText = findViewById(R.id.btnReadText)

        // Inicializa TextToSpeech
        tts = TextToSpeech(this, this)

        // Botão para ler texto
        btnReadText.setOnClickListener {
            val text = editText.text.toString()
            if (text.isNotEmpty()) {
                speakText(text)
            } else {
                Toast.makeText(this, "Digite ou cole algum texto", Toast.LENGTH_SHORT).show()
            }
        }
    }

    // Inicialização do TTS
    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            val result = tts.setLanguage(Locale("pt", "BR")) // Português Brasil
            if (result == TextToSpeech.LANG_MISSING_DATA || result == TextToSpeech.LANG_NOT_SUPPORTED) {
                Toast.makeText(this, "Idioma não suportado", Toast.LENGTH_SHORT).show()
            }
        } else {
            Toast.makeText(this, "Falha ao inicializar TTS", Toast.LENGTH_SHORT).show()
        }
    }

    private fun speakText(text: String) {
        tts.speak(text, TextToSpeech.QUEUE_FLUSH, null, "")
    }

    override fun onDestroy() {
        // Finaliza TTS ao sair da Activity
        if (::tts.isInitialized) {
            tts.stop()
            tts.shutdown()
        }
        super.onDestroy()
    }
}
