package com.leitoruniversalia

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.widget.TextView

class ConhecimentosActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_conhecimentos)

        val txtInfo: TextView = findViewById(R.id.txtInfoConhecimentos)
        txtInfo.text = "Aqui você terá acesso a conhecimentos mundiais, históricos e atuais, em texto, áudio ou vídeo."
    }
}
