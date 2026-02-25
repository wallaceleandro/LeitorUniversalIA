package com.leitoruniversalia

import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val editTexto = findViewById<EditText>(R.id.editTexto)
        val buttonProcessar = findViewById<Button>(R.id.buttonProcessar)

        buttonProcessar.setOnClickListener {
            val textoDigitado = editTexto.text.toString()

            if (textoDigitado.isNotEmpty()) {
                Toast.makeText(this, textoDigitado, Toast.LENGTH_LONG).show()
            } else {
                Toast.makeText(this, "Digite algum texto primeiro", Toast.LENGTH_SHORT).show()
            }
        }
    }
}
