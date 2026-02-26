package com.leitoruniversalia

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.widget.TextView

class CriacaoVideoActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_criacao_video)

        // Placeholder de texto
        val txtInfo: TextView = findViewById(R.id.txtInfoVideo)
        txtInfo.text = "Aqui será a criação de vídeo por IA. Em breve você poderá gerar vídeos automaticamente."
    }
}
