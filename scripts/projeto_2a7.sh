#!/bin/bash
set -e

echo "🚀 Iniciando setup completo: Etapas 2 → 7"

# --------------------------------------------
# 1️⃣ Limpar caches antigos do Gradle
# --------------------------------------------
echo "🧹 Limpando caches antigos do Gradle..."
rm -rf ~/.gradle/caches/
rm -rf ~/.gradle/daemon/
rm -rf ~/.gradle/wrapper/dists/

# --------------------------------------------
# 2️⃣ Atualizar Gradle Wrapper para 8.3
# --------------------------------------------
echo "⚙️ Atualizando Gradle Wrapper para 8.3..."
WRAPPER="./gradle/wrapper/gradle-wrapper.properties"
if [ -f "$WRAPPER" ]; then
    sed -i 's|distributionUrl=.*|distributionUrl=https\://services.gradle.org/distributions/gradle-8.3-all.zip|' $WRAPPER
fi

# --------------------------------------------
# 3️⃣ Limpar build antigo
# --------------------------------------------
echo "🧹 Limpando build antigo..."
./gradlew clean --no-daemon

# --------------------------------------------
# 4️⃣ Atualizar dependências
# --------------------------------------------
echo "🔄 Atualizando dependências..."
./gradlew build --refresh-dependencies --no-daemon

# --------------------------------------------
# 5️⃣ Criar arquivos de layout (Etapas 2 → 7)
# --------------------------------------------
echo "🎨 Criando layout, cores, fontes e botões..."
mkdir -p app/src/main/res/layout
mkdir -p app/src/main/res/values

# Layout principal
cat > app/src/main/res/layout/activity_main.xml <<EOL
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:padding="20dp"
    android:gravity="center"
    android:background="#FFFFFF">

    <EditText
        android:id="@+id/editText"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:hint="Digite o texto para leitura"
        android:padding="12dp"
        android:textColor="#000000"
        android:textSize="18sp"
        android:background="@android:drawable/edit_text"
        android:layout_marginBottom="20dp"/>

    <Button
        android:id="@+id/buttonRead"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Ler em voz alta"
        android:textColor="#FFFFFF"
        android:background="#6200EE"
        android:padding="12dp"/>

</LinearLayout>
EOL

# Cores e strings
cat > app/src/main/res/values/colors.xml <<EOL
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="primaryColor">#6200EE</color>
    <color name="textColor">#000000</color>
    <color name="backgroundColor">#FFFFFF</color>
</resources>
EOL

cat > app/src/main/res/values/strings.xml <<EOL
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">LeitorUniversalIA</string>
    <string name="hint_text">Digite o texto para leitura</string>
    <string name="button_text">Ler em voz alta</string>
</resources>
EOL

# --------------------------------------------
# 6️⃣ Criar MainActivity.kt com Text-to-Speech (Etapa 7)
# --------------------------------------------
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
    private lateinit var editText: EditText
    private lateinit var buttonRead: Button

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        tts = TextToSpeech(this, this)
        editText = findViewById(R.id.editText)
        buttonRead = findViewById(R.id.buttonRead)

        buttonRead.setOnClickListener {
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

# --------------------------------------------
# 7️⃣ Build final para Github
# --------------------------------------------
echo "🏗️ Gerando build para envio ao Github..."
./gradlew assembleDebug --no-daemon

echo "✅ Projeto Etapas 2 → 7 configurado e pronto para Github!"
echo "📌 APK debug disponível em: ./app/build/outputs/apk/debug/app-debug.apk"
