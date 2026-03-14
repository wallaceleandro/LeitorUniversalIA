#!/bin/bash

echo "======================================"
echo "FORÇANDO minSdk = 26"
echo "======================================"

FILE="app/build.gradle"

if [ ! -f "$FILE" ]; then
    echo "Arquivo build.gradle não encontrado!"
    exit 1
fi

echo "Antes da correção:"
grep minSdk $FILE

echo "Aplicando correção..."

sed -i 's/minSdk 21/minSdk 26/g' $FILE
sed -i 's/minSdkVersion 21/minSdkVersion 26/g' $FILE

echo "Depois da correção:"
grep minSdk $FILE

echo "======================================"
echo "Limpando projeto"
echo "======================================"

./gradlew clean

echo "======================================"
echo "Compilando APK"
echo "======================================"

./gradlew assembleDebug --no-daemon
