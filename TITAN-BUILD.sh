#!/bin/bash

# =============================
# TITAN BUILD SYSTEM - ARM64
# Projeto: LeitorUniversalIA
# =============================

PROJECT_DIR="$HOME/LeitorUniversalIA"
LOG_FILE="$PROJECT_DIR/titan-build.log"

echo "🔥 TITAN BUILD ARM64 🔥"
echo "Log: $LOG_FILE"
echo "------------------------------------"

# =============================
# ETAPA 1 — VARREDURA
# =============================

ARCH=$(uname -m)
if [[ "$ARCH" != "aarch64" && "$ARCH" != "arm64" ]]; then
  echo "⚠ Arquitetura não é ARM64. Detectado: $ARCH"
fi

echo "Arquitetura: $ARCH"

# Verificar Java
if ! java -version 2>&1 | grep "17" > /dev/null; then
  echo "❌ Java 17 não encontrado. Instale openjdk-17-jdk"
  exit 1
fi

echo "✅ Java OK"

# Verificar ANDROID_HOME
if [ -z "$ANDROID_HOME" ]; then
  export ANDROID_HOME="$HOME/Android/Sdk"
fi

if [ ! -d "$ANDROID_HOME" ]; then
  echo "❌ ANDROID_HOME inválido: $ANDROID_HOME"
  exit 1
fi

echo "✅ ANDROID_HOME: $ANDROID_HOME"

# Verificar build-tools
BUILD_TOOLS=$(ls $ANDROID_HOME/build-tools 2>/dev/null | sort -V | tail -n 1)

if [ -z "$BUILD_TOOLS" ]; then
  echo "❌ Nenhum build-tools encontrado"
  exit 1
fi

echo "✅ Build-tools detectado: $BUILD_TOOLS"

AAPT2_BIN="$ANDROID_HOME/build-tools/$BUILD_TOOLS/aapt2"

if [ ! -x "$AAPT2_BIN" ]; then
  echo "❌ AAPT2 não executável"
  chmod +x "$AAPT2_BIN"
fi

# Testar AAPT2
if ! "$AAPT2_BIN" version > /dev/null 2>&1; then
  echo "❌ AAPT2 falhou ao executar"
  exit 1
fi

echo "✅ AAPT2 executável"

# Aceitar licenças se necessário
yes | "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" --licenses > /dev/null 2>&1

# Limpar caches corrompidos
rm -rf ~/.gradle/caches
rm -rf "$PROJECT_DIR/app/build"

echo "✅ Ambiente saneado"

# =============================
# ETAPA 2 — JUMPING ENVIRONMENT
# =============================

echo "🚀 Criando ambiente isolado..."

export TITAN_ANDROID_HOME="$ANDROID_HOME"
export PATH="$TITAN_ANDROID_HOME/build-tools/$BUILD_TOOLS:$TITAN_ANDROID_HOME/platform-tools:$PATH"

unset _JAVA_OPTIONS
unset JAVA_TOOL_OPTIONS
unset GRADLE_OPTS

echo "✅ Ambiente isolado ativo"

# =============================
# ETAPA 3 — BUILD MONITORADO
# =============================

cd "$PROJECT_DIR" || exit 1

chmod +x gradlew

echo "🏗 Iniciando build..."

./gradlew clean assembleDebug --no-daemon --refresh-dependencies | tee "$LOG_FILE"

# =============================
# ETAPA 4 — FALLBACK ARM64
# =============================

if grep -q "AAPT2.*Daemon.*failed" "$LOG_FILE"; then
  echo "⚠ Detectado erro de daemon AAPT2. Aplicando fallback..."

  ./gradlew assembleDebug \
  --no-daemon \
  -Dorg.gradle.jvmargs="-Xmx2048m" \
  -Dandroid.aapt2DaemonEnabled=false \
  --refresh-dependencies | tee -a "$LOG_FILE"
fi

# =============================
# ETAPA 5 — RESULTADO FINAL
# =============================

APK_PATH="$PROJECT_DIR/app/build/outputs/apk/debug/app-debug.apk"

if [ -f "$APK_PATH" ]; then
  echo "------------------------------------"
  echo "✅ BUILD CONCLUÍDO COM SUCESSO"
  echo "APK: $APK_PATH"
  echo "------------------------------------"
else
  echo "------------------------------------"
  echo "❌ BUILD FALHOU"
  echo "Verifique o log: $LOG_FILE"
  echo "------------------------------------"
fi
