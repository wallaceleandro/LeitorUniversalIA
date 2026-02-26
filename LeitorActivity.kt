	package com.leitoruniversalia

import android.os.Bundle
import android.speech.tts.TextToSpeech
import android.widget.Button
import android.widget.EditText
import androidx.appcompat.app.AppCompatActivity
import com.leitoruniversalia.data.AppDatabase
import com.leitoruniversalia.data.AudioText
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.util.*

class LeitorActivity : AppCompatActivity(), TextToSpeech.OnInitListener {

    private lateinit var tts: TextToSpeech
    private lateinit var edtTexto: EditText
    private lateinit var btnLer: Button
    private lateinit var btnSalvar: Button

    private val db by lazy { AppDatabase.getDatabase(this).audioTextDao() }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_leitor)

        tts = TextToSpeech(this, this)

        edtTexto = findViewById(R.id.edtTexto)
        btnLer = findViewById(R.id.btnLer)
        btnSalvar = findViewById(R.id.btnSalvar)

        btnLer.setOnClickListener {
            lerTexto(edtTexto.text.toString())
        }

        btnSalvar.setOnClickListener {
            salvarTexto(edtTexto.text.toString())
        }
    }

    private fun lerTexto(texto: String) {
        if (texto.isNotEmpty()) {
            // Voz humana natural (Android TTS, futura integração IA central)
            tts.speak(texto, TextToSpeech.QUEUE_FLUSH, null, "tts1")
        }
    }

    private fun salvarTexto(texto: String) {
        if (texto.isNotEmpty()) {
            CoroutineScope(Dispatchers.IO).launch {
                db.insert(AudioText(title = "Texto salvo", content = texto))
            }
        }
    }

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            tts.language = Locale.getDefault()
        }
    }

    override fun onDestroy() {
        tts.stop()
        tts.shutdown()
        super.onDestroy()
    }
}
