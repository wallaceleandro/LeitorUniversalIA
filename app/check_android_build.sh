#!/bin/bash

echo "=================================="
echo "  Iniciando checagem do ambiente"
echo "=================================="

if [ -n "$PREFIX" ] && [ -d "$PREFIX" ]; then
    SYSTEM="TERMUX"
else
    SYSTEM="LINUX"
fi
echo "Sistema detectado: $SYSTEM"
echo ""

if command -v java >/dev/null 2>&1; then
    JAVA_VER=$(java -version 2>&1 | head -n 1)
    echo "[OK] Java encontrado: $JAVA_VER"
else
    echo "[ERRO] Java não encontrado!"
    if [ "$SYSTEM" = "TERMUX" ]; then
        echo "Execute: pkg install openjdk-17 -y"
    else
        echo "Execute: sudo apt install openjdk-17-jdk -y"
    fi
    echo ""
fi

if command -v gradle >/dev/null 2>&1; then
    GRADLE_VER=$(gradle -v | grep "Gradle" | head -n 1)
    echo "[OK] Gradle encontrado: $GRADLE_VER"
elif [ -f "./gradlew" ]; then
    echo "[OK] Gradle Wrapper encontrado (gradlew)"
else
    echo "[ERRO] Gradle não encontrado!"
    if [ "$SYSTEM" = "TERMUX" ]; then
        echo "Execute: pkg install gradle -y"
    else
        echo "Execute: sudo apt install gradle -y"
    fi
    echo ""
fi

if [ -n "$ANDROID_HOME" ]; then
    echo "[OK] Android SDK detectado em: $ANDROID_HOME"
else
    echo "[AVISO] Android SDK não detectado. Variável ANDROID_HOME não setada."
fi
echo ""

echo "Checando arquivos do projeto Android..."
FILES_OK=1

check_file() {
    if [ -f "$1" ]; then
        echo "[OK] $1 encontrado"
    else
        echo "[ERRO] $1 não encontrado"
        FILES_OK=0
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo "[OK] Diretório $1 encontrado"
    else
        echo "[ERRO] Diretório $1 não encontrado"
        FILES_OK=0
    fi
}

check_file "build.gradle"
check_file "settings.gradle"
check_file "app/build.gradle"
check_file "gradlew"
check_dir "gradle/wrapper"

if [ $FILES_OK -eq 0 ]; then
    echo ""
    echo "[ERRO] Alguns arquivos essenciais estão faltando. Corrija antes de tentar build."
    exit 1
fi

echo ""
echo "Iniciando teste de build assembleDebug..."

if [ -f "./gradlew" ]; then
    chmod +x ./gradlew
    ./gradlew assembleDebug
else
    gradle assembleDebug
fi

echo ""
echo "=================================="
echo "Verificação finalizada!"
echo "Se o build foi bem sucedido, seu ambiente está pronto."
echo "=================================="
