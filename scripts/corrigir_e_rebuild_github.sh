#!/bin/bash
set -e

echo "======================================"
echo "🔧 CORREÇÃO TOTAL + REBUILD GITHUB"
echo "======================================"

# -----------------------------------
# 1️⃣ DEFINIR PACOTE PADRÃO
# -----------------------------------
PACKAGE="com.leitoruniversalia"

echo "📦 Ajustando estrutura do pacote..."

# Criar pasta correta
mkdir -p app/src/main/java/com/leitoruniversalia

# Mover MainActivity se estiver em outro local
find app/src/main/java -name "MainActivity.kt" | while read file; do
    cp "$file" app/src/main/java/com/leitoruniversalia/MainActivity.kt
done

# Remover versões duplicadas
rm -rf app/src/main/java/com/leitor/universal || true

# -----------------------------------
# 2️⃣ CORRIGIR build.gradle (Module app)
# -----------------------------------
echo "⚙️ Corrigindo namespace e applicationId..."

BUILD_FILE="app/build.gradle"

if [ -f "$BUILD_FILE" ]; then
    sed -i "s/namespace .*/namespace \"$PACKAGE\"/" $BUILD_FILE
    sed -i "s/applicationId .*/applicationId \"$PACKAGE\"/" $BUILD_FILE
fi

# -----------------------------------
# 3️⃣ CORRIGIR MainActivity
# -----------------------------------
echo "🛠 Ajustando MainActivity..."

cat > app/src/main/java/com/leitoruniversalia/MainActivity.kt <<EOL
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
                tts.speak(text, TextToSpeech.QUEUE_FLUSH, null, "")
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
EOL

# -----------------------------------
# 4️⃣ CORRIGIR LAYOUT
# -----------------------------------
echo "🎨 Ajustando layout..."

mkdir -p app/src/main/res/layout

cat > app/src/main/res/layout/activity_main.xml <<EOL
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:padding="20dp"
    android:gravity="center">

    <EditText
        android:id="@+id/editText"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="Digite o texto"
        android:layout_marginBottom="20dp"/>

    <Button
        android:id="@+id/buttonRead"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Ler em voz alta"/>
</LinearLayout>
EOL

# -----------------------------------
# 5️⃣ LIMPEZA TOTAL
# -----------------------------------
echo "🧹 Limpando caches..."

./gradlew clean --no-daemon || true
rm -rf ~/.gradle/caches/
rm -rf .gradle/

# -----------------------------------
# 6️⃣ BUILD FINAL
# -----------------------------------
echo "🏗️ Gerando build para GitHub..."

./gradlew assembleDebug --no-daemon

echo "======================================"
echo "✅ PROJETO CORRIGIDO E PRONTO"
echo "📦 APK em: app/build/outputs/apk/debug/"
echo "======================================"
