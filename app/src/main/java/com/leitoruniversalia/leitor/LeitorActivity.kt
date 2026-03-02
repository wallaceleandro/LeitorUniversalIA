package com.leitoruniversalia.leitor

import android.os.Bundle
import android.speech.tts.TextToSpeech
import android.widget.*
import androidx.appcompat.app.AppCompatActivity
import java.util.*

class LeitorActivity : AppCompatActivity(), TextToSpeech.OnInitListener {

    private lateinit var tts: TextToSpeech
    private lateinit var editText: EditText
    private lateinit var statusVoice: TextView
    private lateinit var seekSpeed: SeekBar
    private lateinit var seekPitch: SeekBar

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_leitor)

        editText = findViewById(R.id.editText)
        statusVoice = findViewById(R.id.statusVoice)
        seekSpeed = findViewById(R.id.seekSpeed)
        seekPitch = findViewById(R.id.seekPitch)

        val btnPlay = findViewById<Button>(R.id.btnPlay)
        val btnPause = findViewById<Button>(R.id.btnPause)
        val btnStop = findViewById<Button>(R.id.btnStop)

        tts = TextToSpeech(this, this)

        seekSpeed.progress = 100
        seekPitch.progress = 100

        btnPlay.setOnClickListener {
            val text = editText.text.toString()
            if (text.isNotEmpty()) {
                val speed = seekSpeed.progress / 100f
                val pitch = seekPitch.progress / 100f

                tts.setSpeechRate(speed)
                tts.setPitch(pitch)

                tts.speak(text, TextToSpeech.QUEUE_FLUSH, null, null)
                statusVoice.text = "Status: Falando..."
            }
        }

        btnPause.setOnClickListener {
            tts.stop()
            statusVoice.text = "Status: Pausado"
        }

        btnStop.setOnClickListener {
            tts.stop()
            statusVoice.text = "Status: Parado"
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
