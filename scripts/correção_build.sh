#!/bin/bash
set -e  # Para parar se algum comando falhar

echo "==============================================="
echo " 🔧 Iniciando correção e build do LeitorUniversalIA"
echo "==============================================="

# 1️⃣ Limpar caches do Gradle e AAPT2
echo "🗑️  Limpando caches do Gradle e AAPT2..."
rm -rf ~/.gradle/caches/
rm -rf ~/.gradle/daemon/
rm -rf ~/.gradle/wrapper/dists/

# 2️⃣ Forçar Gradle Wrapper atualizado
echo "⚙️  Atualizando Gradle Wrapper para 8.3..."
WRAPPER_FILE="./gradle/wrapper/gradle-wrapper.properties"
if [ -f "$WRAPPER_FILE" ]; then
    sed -i 's|distributionUrl=.*|distributionUrl=https\://services.gradle.org/distributions/gradle-8.3-all.zip|' $WRAPPER_FILE
else
    echo "❌ gradle-wrapper.properties não encontrado!"
fi

# 3️⃣ Limpar build antigo
echo "🧹 Limpando build antigo..."
./gradlew clean

# 4️⃣ Atualizar dependências
echo "⬇️  Baixando e atualizando dependências..."
./gradlew build --refresh-dependencies --no-daemon

# 5️⃣ Gerar APK debug
echo "📦 Gerando APK debug..."
./gradlew assembleDebug --no-daemon

# 6️⃣ Build concluído
echo "✅ Build concluído com sucesso!"
echo "🏁 APK debug disponível em: ./app/build/outputs/apk/debug/app-debug.apk"

# 7️⃣ Mensagem final
echo "==============================================="
echo " ⚡ LeitorUniversalIA pronto para testes no dispositivo!"
echo "==============================================="
