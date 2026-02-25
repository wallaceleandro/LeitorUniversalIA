package com.leitoruniversalia

import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val editTexto = findViewById<EditText>(R.id.editTexto)
        val buttonProcessar = findViewById<Button>(R.id.buttonProcessar)
        val textResultado = findViewById<TextView>(R.id.textResultado)

        buttonProcessar.setOnClickListener {

            val textoDigitado = editTexto.text.toString()

            if (textoDigitado.isNotEmpty()) {
                textResultado.text = textoDigitado
            } else {
                textResultado.text = "Digite algo primeiro."
            }

        }
    }
}
