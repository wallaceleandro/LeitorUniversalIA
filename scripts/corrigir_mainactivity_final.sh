#!/bin/bash
set -e

echo "======================================"
echo "🔧 CORREÇÃO DEFINITIVA DO PROJETO"
echo "======================================"

# remover pacote antigo
echo "🧹 Removendo código duplicado..."

rm -rf app/src/main/java/com/leitor/universal

# garantir pasta correta
mkdir -p app/src/main/java/com/leitoruniversalia

# recriar MainActivity limpa
echo "📱 Recriando MainActivity..."

cat > app/src/main/java/com/leitoruniversalia/MainActivity.kt <<EOF
package com.leitoruniversalia

import android.os.Bundle
import android.speech.tts.TextToSpeech
import androidx.appcompat.app.AppCompatActivity
import android.widget.Button
import android.widget.EditText
import java.util.*

class MainActivity : AppCompatActivity(), TextToSpeech.OnInitListener {

    private lateinit var tts: TextToSpeech

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        tts = TextToSpeech(this, this)

        val editText = findViewById<EditText>(R.id.editText)
        val button = findViewById<Button>(R.id.buttonRead)

        button.setOnClickListener {
            val text = editText.text.toString()

            if (text.isNotEmpty()) {
                tts.speak(text, TextToSpeech.QUEUE_FLUSH, null, null)
            }
        }
    }

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            tts.language = Locale("pt", "BR")
        }
    }

    override fun onDestroy() {
        if (::tts.isInitialized) {
            tts.stop()
            tts.shutdown()
        }
        super.onDestroy()
    }
}
EOF

# limpar gradle
echo "🧹 Limpando build..."

./gradlew clean --no-daemon

echo "======================================"
echo "✅ CORREÇÃO FINALIZADA"
echo "======================================"
