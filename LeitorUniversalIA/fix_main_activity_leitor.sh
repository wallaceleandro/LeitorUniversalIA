#!/bin/bash

echo "Conectando MainActivity ao novo leitor..."

APP="app/src/main"

cat > $APP/java/com/leitoruniversalia/MainActivity.kt << 'EOF'
package com.leitoruniversalia

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import modules.leitor.ui.LeitorActivity

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_main)

        val abrir = findViewById<Button>(R.id.abrirLivro)

        abrir.setOnClickListener {

            val intent = Intent(this, LeitorActivity::class.java)

            startActivity(intent)

        }
    }
}
EOF

echo "MainActivity atualizada."
