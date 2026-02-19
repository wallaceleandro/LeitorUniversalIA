#!/bin/bash
set -e

echo "==============================="
echo "SCRIPT SUPREMO DE BUILD APK"
echo "==============================="

# 1️⃣ Atualizar pacotes Linux
echo "[1] Atualizando pacotes..."
sudo apt update -y
sudo apt upgrade -y

# 2️⃣ Instalar dependências essenciais
echo "[2] Instalando dependências essenciais..."
sudo apt install -y openjdk-17-jdk zlib1g libncurses-dev libstdc++6 unzip wget curl git

# 3️⃣ Configurar Android SDK
echo "[3] Configurando Android SDK..."
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH
echo "ANDROID_HOME=$ANDROID_HOME"
sdkmanager --version || echo "⚠️ SDK Manager não encontrado, instale o cmdline-tools."

# 4️⃣ Limpar caches do Gradle
echo "[4] Limpando caches do Gradle..."
rm -rf ~/.gradle/caches/transforms-4/
rm -rf ~/.gradle/caches/modules-2/files-2.1/androidx.appcompat/
rm -rf ~/.gradle/caches/modules-2/files-2.1/androidx.core/
rm -rf app/build

# 5️⃣ Corrigir gradle.properties
echo "[5] Corrigindo gradle.properties..."
cat <<EOL > gradle.properties
# Forçar AndroidX
android.useAndroidX=true
android.enableJetifier=true
android.aapt2FromMaven=true
android.suppressUnsupportedCompileSdk=34
kotlin.code.style=official
EOL

# 6️⃣ Baixar AAPT2 manualmente (correção do erro)
echo "[6] Baixando AAPT2 manualmente..."
mkdir -p $HOME/Android/aapt2
wget -O $HOME/Android/aapt2/aapt2.jar https://dl.google.com/android/maven2/com/android/tools/build/aapt2/8.1.0-10154469/aapt2-8.1.0-10154469-linux.jar

# 7️⃣ Tornar gradlew executável
echo "[7] Preparando Gradle Wrapper..."
chmod +x ./gradlew

# 8️⃣ Limpar e construir APK
echo "[8] Executando build debug..."
./gradlew clean assembleDebug --refresh-dependencies --no-daemon

# 9️⃣ Concluir
echo "==============================="
echo "BUILD CONCLUÍDA!"
echo "APK gerado em app/build/outputs/apk/debug/app-debug.apk"
echo "==============================="
