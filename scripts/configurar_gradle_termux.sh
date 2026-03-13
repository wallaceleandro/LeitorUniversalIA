#!/bin/bash
# ========================================
# Configuração do projeto Android para Termux
# Gradle 7.6 + Android Plugin 7.4.2
# ========================================

echo "=== Configurando Gradle Wrapper para 7.6 ==="
./gradlew wrapper --gradle-version 7.6 --distribution-type all

echo "=== Alterando Android Gradle Plugin para 7.4.2 ==="
BUILD_FILE="./build.gradle"
if [ -f "$BUILD_FILE" ]; then
    # Substitui a linha do plugin antigo
    sed -i "s/classpath 'com.android.tools.build:gradle:.*'/classpath 'com.android.tools.build:gradle:7.4.2'/g" $BUILD_FILE
    echo "Plugin alterado com sucesso."
else
    echo "Erro: build.gradle não encontrado na raiz."
    exit 1
fi

echo "=== Limpando cache do Gradle ==="
rm -rf ~/.gradle/caches/
echo "Cache do Gradle limpo."

echo "=== Limpando build antigo ==="
./gradlew clean

echo "=== Configuração concluída! ==="
echo "Agora você pode rodar: ./gradlew assembleDebug"
