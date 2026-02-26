package com.leitoruniversalia

import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
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
    private lateinit var btnCopy: Button
    private lateinit var btnSave: Button
    private lateinit var btnRecord: Button

    private lateinit var tts: TextToSpeech

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_leitor)

        // Vincular elementos do layout
        editText = findViewById(R.id.editText)
        btnReadText = findViewById(R.id.btnReadText)
        btnCopy = findViewById(R.id.btnCopy)
        btnSave = findViewById(R.id.btnSave)
        btnRecord = findViewById(R.id.btnRecord)

        // Inicializar TextToSpeech
        tts = TextToSpeech(this, this)

        // Ler Texto
        btnReadText.setOnClickListener {
            val text = editText.text.toString()
            if (text.isNotEmpty()) {
                tts.speak(text, TextToSpeech.QUEUE_FLUSH, null, "tts1")
            } else {
                Toast.makeText(this, "Digite algum texto!", Toast.LENGTH_SHORT).show()
            }
        }

        // Copiar texto
        btnCopy.setOnClickListener {
            val clipboard = getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
            val clip = ClipData.newPlainText("Texto", editText.text.toString())
            clipboard.setPrimaryClip(clip)
            Toast.makeText(this, "Texto copiado!", Toast.LENGTH_SHORT).show()
        }

        // Salvar texto local (exemplo simples)
        btnSave.setOnClickListener {
            val text = editText.text.toString()
            if (text.isNotEmpty()) {
                openFileOutput("texto_salvo.txt", Context.MODE_PRIVATE).use {
                    it.write(text.toByteArray())
                }
                Toast.makeText(this, "Texto salvo!", Toast.LENGTH_SHORT).show()
            } else {
                Toast.makeText(this, "Nada para salvar!", Toast.LENGTH_SHORT).show()
            }
        }

        // Áudio existente (apenas exemplo)
        btnRecord.setOnClickListener {
            Toast.makeText(this, "Aqui você pode integrar áudios do seu celular", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            tts.language = Locale("pt", "BR") // Voz humana em português
        }
    }

    override fun onDestroy() {
        tts.stop()
        tts.shutdown()
        super.onDestroy()
    }
}
