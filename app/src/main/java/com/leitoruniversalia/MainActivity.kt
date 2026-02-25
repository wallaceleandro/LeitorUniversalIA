package com.leitoruniversalia

import android.os.Bundle
import android.widget.*
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    private lateinit var editTexto: EditText
    private lateinit var buttonProcessar: Button
    private lateinit var textResultado: TextView

    private lateinit var buttonLeitor: Button
    private lateinit var buttonCNH: Button
    private lateinit var buttonConversao: Button
    private lateinit var buttonTemas: Button
    private lateinit var buttonExtra1: Button
    private lateinit var buttonExtra2: Button

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Inicializar campos
        editTexto = findViewById(R.id.editTexto)
        buttonProcessar = findViewById(R.id.buttonProcessar)
        textResultado = findViewById(R.id.textResultado)

        buttonLeitor = findViewById(R.id.buttonLeitor)
        buttonCNH = findViewById(R.id.buttonCNH)
        buttonConversao = findViewById(R.id.buttonConversao)
        buttonTemas = findViewById(R.id.buttonTemas)
        buttonExtra1 = findViewById(R.id.buttonExtra1)
        buttonExtra2 = findViewById(R.id.buttonExtra2)

        // Listener do botão principal
        buttonProcessar.setOnClickListener {
            val textoDigitado = editTexto.text.toString().trim()
            if (textoDigitado.isEmpty()) {
                textResultado.text = "Digite algo primeiro."
            } else {
                textResultado.text = "Texto processado com sucesso:\n\n$textoDigitado"
            }
        }

        // Listeners dos futuros botões (ainda sem funções)
        buttonLeitor.setOnClickListener {
            Toast.makeText(this, "Leitor de Texto (a implementar)", Toast.LENGTH_SHORT).show()
        }

        buttonCNH.setOnClickListener {
            Toast.makeText(this, "CNH (a implementar)", Toast.LENGTH_SHORT).show()
        }

        buttonConversao.setOnClickListener {
            Toast.makeText(this, "Conversão Texto ↔ Áudio (a implementar)", Toast.LENGTH_SHORT).show()
        }

        buttonTemas.setOnClickListener {
            Toast.makeText(this, "Temas Mundiais (a implementar)", Toast.LENGTH_SHORT).show()
        }

        buttonExtra1.setOnClickListener {
            Toast.makeText(this, "Função Extra 1 (a implementar)", Toast.LENGTH_SHORT).show()
        }

        buttonExtra2.setOnClickListener {
            Toast.makeText(this, "Função Extra 2 (a implementar)", Toast.LENGTH_SHORT).show()
        }
    }
}
