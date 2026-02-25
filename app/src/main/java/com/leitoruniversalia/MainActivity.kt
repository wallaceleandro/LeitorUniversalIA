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

            if (textoDigitado.isEmpty()) {
                textResultado.text = "Digite algo primeiro."
                return@setOnClickListener
            }

            val resposta = when {
                textoDigitado.length > 100 ->
                    "Resumo: ${textoDigitado.take(100)}..."
                textoDigitado.trim().endsWith("?") ->
                    "Pergunta detectada. Em breve a IA responderá isso corretamente."
                else ->
                    "Texto processado com sucesso:\n\n$textoDigitado"
            }

            textResultado.text = resposta
        }
    }
}
