#!/bin/bash

echo "========================================"
echo "DIAGNOSTICO COMPLETO DO PROJETO ANDROID"
echo "========================================"

echo ""
echo "1️⃣ Verificando módulos do projeto..."
echo "----------------------------------------"

if [ -f settings.gradle ]; then
cat settings.gradle
else
echo "Arquivo settings.gradle não encontrado"
fi

echo ""
echo "2️⃣ Listando módulos com AndroidManifest..."
echo "----------------------------------------"

find . -name "AndroidManifest.xml"

echo ""
echo "3️⃣ Verificando diretório que o Gradle compila..."
echo "----------------------------------------"

if [ -d app ]; then
echo "Módulo principal encontrado:"
ls app
else
echo "Módulo app não encontrado"
fi

echo ""
echo "4️⃣ Activities declaradas no projeto..."
echo "----------------------------------------"

grep -R "<activity" .

echo ""
echo "5️⃣ Activity inicial (launcher)..."
echo "----------------------------------------"

grep -R "MAIN" .

echo ""
echo "6️⃣ APKs gerados..."
echo "----------------------------------------"

find . -name "*.apk"

echo ""
echo "7️⃣ Verificando layout usado..."
echo "----------------------------------------"

grep -R "setContentView" .

echo ""
echo "========================================"
echo "DIAGNOSTICO FINALIZADO"
echo "========================================"
