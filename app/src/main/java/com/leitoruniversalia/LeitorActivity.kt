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
    private lateinit var btnAddAudio: Button
    private lateinit var btnCopy: Button
    private lateinit var btnSave: Button

    private var tts: TextToSpeech? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_leitor)

        // Referências do layout
        editText = findViewById(R.id.editText)
        btnReadText = findViewById(R.id.btnReadText)
        btnAddAudio = findViewById(R.id.btnRecord) // pode mudar para AddAudio futuramente
        btnCopy = findViewById(R.id.btnCopy)
        btnSave = findViewById(R.id.btnSave)

        // Inicializa TextToSpeech
        tts = TextToSpeech(this, this)

        // Botão Ler Texto
        btnReadText.setOnClickListener {
            val text = editText.text.toString()
            if (text.isNotEmpty()) {
                tts?.speak(text, TextToSpeech.QUEUE_FLUSH, null, "tts1")
            } else {
                Toast.makeText(this, "Digite ou cole algum texto!", Toast.LENGTH_SHORT).show()
            }
        }

        // Botão Adicionar Áudio (placeholder)
        btnAddAudio.setOnClickListener {
            Toast.makeText(this, "Função de adicionar áudio ainda não implementada.", Toast.LENGTH_SHORT).show()
        }

        // Botão Copiar texto
        btnCopy.setOnClickListener {
            val clipboard = getSystemService(CLIPBOARD_SERVICE) as android.content.ClipboardManager
            val clip = android.content.ClipData.newPlainText("texto", editText.text.toString())
            clipboard.setPrimaryClip(clip)
            Toast.makeText(this, "Texto copiado para área de transferência.", Toast.LENGTH_SHORT).show()
        }

        // Botão Salvar texto (placeholder)
        btnSave.setOnClickListener {
            Toast.makeText(this, "Função de salvar texto ainda não implementada.", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            tts?.language = Locale("pt", "BR") // Português do Brasil
        } else {
            Toast.makeText(this, "Falha ao inicializar TextToSpeech.", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onDestroy() {
        tts?.stop()
        tts?.shutdown()
        super.onDestroy()
    }
}
