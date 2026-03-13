package com.leitor.universal

import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val texto = findViewById<EditText>(R.id.editText)
        val botao = findViewById<Button>(R.id.btnLer)

        botao.setOnClickListener {

            val conteudo = texto.text.toString()

            if (conteudo.isEmpty()) {

                Toast.makeText(this,"Digite um texto",Toast.LENGTH_SHORT).show()

            } else {

                Toast.makeText(this,conteudo,Toast.LENGTH_LONG).show()

            }

        }

    }

}
