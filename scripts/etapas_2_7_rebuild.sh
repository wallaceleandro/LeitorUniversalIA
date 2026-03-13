#!/bin/bash
set -e

echo "======================================"
echo "  RECONSTRUÇÃO SEGURA ETAPAS 2 → 7"
echo "======================================"

# 1️⃣ Parar Gradle
echo "🛑 Parando Gradle..."
./gradlew --stop 2>/dev/null || true

# 2️⃣ Limpeza segura (NÃO apaga código)
echo "🧹 Limpando build..."
./gradlew clean

rm -rf app/build

# 3️⃣ Garantir Gradle 8.3 (compatível com Android moderno)
echo "⚙️ Ajustando Gradle Wrapper..."
WRAPPER="gradle/wrapper/gradle-wrapper.properties"

if [ -f "$WRAPPER" ]; then
    sed -i 's|distributionUrl=.*|distributionUrl=https\://services.gradle.org/distributions/gradle-8.3-all.zip|' "$WRAPPER"
fi

# 4️⃣ Criar layout corretamente
echo "🎨 Criando layout..."

mkdir -p app/src/main/res/layout
mkdir -p app/src/main/res/values

cat > app/src/main/res/layout/activity_main.xml <<EOL
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center"
    android:padding="24dp">

    <EditText
        android:id="@+id/editText"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="Digite o texto"
        android:textSize="18sp"
        android:padding="12dp"/>

    <Button
        android:id="@+id/buttonRead"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Ler em voz alta"
        android:layout_marginTop="20dp"/>
</LinearLayout>
EOL

# 5️⃣ Garantir MainActivity funcional
echo "📱 Criando MainActivity com Text-to-Speech..."

mkdir -p app/src/main/java/com/leitoruniversalia

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

# 6️⃣ Build completo
echo "🏗️ Gerando APK..."
./gradlew assembleDebug --no-daemon

# 7️⃣ Criar APK com nome único
APK="app/build/outputs/apk/debug/app-debug.apk"

if [ -f "$APK" ]; then
    DATA=$(date +"%Y%m%d-%H%M")
    cp "$APK" "LeitorUniversalIA-$DATA.apk"
    echo "✅ APK gerado com sucesso!"
    echo "📦 Arquivo: LeitorUniversalIA-$DATA.apk"
else
    echo "❌ Erro: APK não foi gerado."
    exit 1
fi

echo "======================================"
echo "  PROCESSO CONCLUÍDO COM SUCESSO"
echo "======================================"
