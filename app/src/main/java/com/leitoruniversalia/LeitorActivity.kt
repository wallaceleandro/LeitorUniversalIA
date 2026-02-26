package com.leitoruniversalia

import android.app.Activity
import android.os.Bundle
import android.speech.tts.TextToSpeech
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import java.util.Locale

class LeitorActivity : Activity(), TextToSpeech.OnInitListener {

    private lateinit var editText: EditText
    private lateinit var btnReadText: Button
    private lateinit var btnAudio: Button
    private lateinit var btnCopy: Button
    private lateinit var btnSave: Button

    private lateinit var tts: TextToSpeech

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_leitor)

        // Inicializa o TTS
        tts = TextToSpeech(this, this)

        // Vincula os botões e o EditText
        editText = findViewById(R.id.editText)
        btnReadText = findViewById(R.id.btnReadText)
        btnAudio = findViewById(R.id.btnAudio)
        btnCopy = findViewById(R.id.btnCopy)
        btnSave = findViewById(R.id.btnSave)

        // Botão Ler Texto
        btnReadText.setOnClickListener {
            val text = editText.text.toString()
            if (text.isNotEmpty()) {
                tts.speak(text, TextToSpeech.QUEUE_FLUSH, null, "tts1")
            } else {
                Toast.makeText(this, "Digite algum texto", Toast.LENGTH_SHORT).show()
            }
        }

        // Botão Usar Áudio (selecionar ou adicionar)
        btnAudio.setOnClickListener {
            Toast.makeText(this, "Funcionalidade de usar áudio em desenvolvimento", Toast.LENGTH_SHORT).show()
        }

        // Botão Copiar
        btnCopy.setOnClickListener {
            val clipboard = getSystemService(CLIPBOARD_SERVICE) as android.content.ClipboardManager
            val clip = android.content.ClipData.newPlainText("text", editText.text.toString())
            clipboard.setPrimaryClip(clip)
            Toast.makeText(this, "Texto copiado", Toast.LENGTH_SHORT).show()
        }

        // Botão Salvar
        btnSave.setOnClickListener {
            Toast.makeText(this, "Funcionalidade de salvar em desenvolvimento", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            val result = tts.setLanguage(Locale("pt", "BR"))
            if (result == TextToSpeech.LANG_MISSING_DATA || result == TextToSpeech.LANG_NOT_SUPPORTED) {
                Toast.makeText(this, "Idioma não suportado", Toast.LENGTH_SHORT).show()
            }
        } else {
            Toast.makeText(this, "Falha ao inicializar TTS", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onDestroy() {
        tts.stop()
        tts.shutdown()
        super.onDestroy()
    }
}
