package com.leitoruniversalia

import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.speech.RecognizerIntent
import android.speech.tts.TextToSpeech
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import java.util.*

class MainActivity : AppCompatActivity() {

    private lateinit var editText: EditText
    private lateinit var btnReadText: Button
    private lateinit var btnRecord: Button
    private lateinit var btnCopy: Button
    private lateinit var btnSave: Button
    private lateinit var tts: TextToSpeech

    private val SPEECH_CODE = 100

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Conectar elementos do XML
        editText = findViewById(R.id.editText)
        btnReadText = findViewById(R.id.btnReadText)
        btnRecord = findViewById(R.id.btnRecord)
        btnCopy = findViewById(R.id.btnCopy)
        btnSave = findViewById(R.id.btnSave)

        // Inicializar Text-to-Speech
        tts = TextToSpeech(this) { status ->
            if (status == TextToSpeech.SUCCESS) {
                tts.language = Locale("pt", "BR")
            }
        }

        // BOTÃO LER TEXTO
        btnReadText.setOnClickListener {
            val texto = editText.text.toString()

            if (texto.isNotEmpty()) {
                tts.speak(texto, TextToSpeech.QUEUE_FLUSH, null, null)
            } else {
                Toast.makeText(this, "Digite algum texto primeiro", Toast.LENGTH_SHORT).show()
            }
        }

        // BOTÃO GRAVAR ÁUDIO
        btnRecord.setOnClickListener {

            val intent = Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH)
            intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                RecognizerIntent.LANGUAGE_MODEL_FREE_FORM)
            intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, "pt-BR")

            try {
                startActivityForResult(intent, SPEECH_CODE)
            } catch (e: ActivityNotFoundException) {
                Toast.makeText(this,
                    "Reconhecimento de voz não disponível",
                    Toast.LENGTH_SHORT).show()
            }
        }

        // BOTÃO COPIAR
        btnCopy.setOnClickListener {

            val clipboard = getSystemService(Context.CLIPBOARD_SERVICE)
                    as ClipboardManager

            val clip = ClipData.newPlainText("texto", editText.text.toString())
            clipboard.setPrimaryClip(clip)

            Toast.makeText(this, "Texto copiado", Toast.LENGTH_SHORT).show()
        }

        // BOTÃO SALVAR
        btnSave.setOnClickListener {

            val nomeArquivo = "texto_salvo.txt"

            openFileOutput(nomeArquivo, Context.MODE_PRIVATE).use {
                it.write(editText.text.toString().toByteArray())
            }

            Toast.makeText(this,
                "Texto salvo com sucesso",
                Toast.LENGTH_SHORT).show()
        }
    }

    override fun onActivityResult(requestCode: Int,
                                  resultCode: Int,
                                  data: Intent?) {

        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == SPEECH_CODE && resultCode == Activity.RESULT_OK) {

            val resultado =
                data?.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS)

            if (!resultado.isNullOrEmpty()) {
                editText.setText(resultado[0])
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        tts.stop()
        tts.shutdown()
    }
}
