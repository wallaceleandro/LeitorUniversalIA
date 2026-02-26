package com.leitoruniversalia

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    private lateinit var btnLeitorTexto: Button
    private lateinit var btnCriacaoVideo: Button
    private lateinit var btnConhecimentos: Button

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        btnLeitorTexto = findViewById(R.id.btnLeitorTexto)
        btnCriacaoVideo = findViewById(R.id.btnCriacaoVideo)
        btnConhecimentos = findViewById(R.id.btnConhecimentos)

        btnLeitorTexto.setOnClickListener {
            val intent = Intent(this, LeitorActivity::class.java)
            startActivity(intent)
        }

        btnCriacaoVideo.setOnClickListener {
            // Futuro: abrir activity de criação de vídeo
            val intent = Intent(this, CriacaoVideoActivity::class.java)
            startActivity(intent)
        }

        btnConhecimentos.setOnClickListener {
            // Futuro: abrir activity de conhecimentos
            val intent = Intent(this, ConhecimentosActivity::class.java)
            startActivity(intent)
        }
    }
}
