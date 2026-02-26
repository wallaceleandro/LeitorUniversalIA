cat > app/src/main/java/com/leitoruniversalia/MainActivity.kt << 'EOF'
package com.leitoruniversalia

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.LinearLayout
import android.widget.ScrollView
import android.widget.Toast

class MainActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Layout programático (mais leve e flexível)
        val scrollView = ScrollView(this)
        val mainLayout = LinearLayout(this)
        mainLayout.orientation = LinearLayout.VERTICAL
        mainLayout.setPadding(16, 16, 16, 16)
        scrollView.addView(mainLayout)

        // Botão Leitor de Texto
        val btnLeitor = Button(this)
        btnLeitor.text = "Leitor de Texto"
        btnLeitor.setOnClickListener {
            val intent = Intent(this, LeitorActivity::class.java)
            startActivity(intent)
        }
        mainLayout.addView(btnLeitor)

        // Botão Criação de Vídeo (placeholder)
        val btnVideo = Button(this)
        btnVideo.text = "Criação de Vídeo IA"
        btnVideo.setOnClickListener {
            Toast.makeText(this, "Função Criação de Vídeo em desenvolvimento", Toast.LENGTH_SHORT).show()
        }
        mainLayout.addView(btnVideo)

        // Botão CNH (placeholder)
        val btnCNH = Button(this)
        btnCNH.text = "CNH - Conhecimentos"
        btnCNH.setOnClickListener {
            Toast.makeText(this, "Função CNH em desenvolvimento", Toast.LENGTH_SHORT).show()
        }
        mainLayout.addView(btnCNH)

        // Botão Conhecimentos Gerais (placeholder)
        val btnConhecimentos = Button(this)
        btnConhecimentos.text = "Conhecimentos Gerais"
        btnConhecimentos.setOnClickListener {
            Toast.makeText(this, "Função Conhecimentos em desenvolvimento", Toast.LENGTH_SHORT).show()
        }
        mainLayout.addView(btnConhecimentos)

        setContentView(scrollView)
    }
}
EOF
