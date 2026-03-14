#!/bin/bash

echo "======================================"
echo "ATUALIZANDO minSdkVersion PARA 26"
echo "======================================"

FILE=app/build.gradle

sed -i 's/minSdkVersion 21/minSdkVersion 26/g' $FILE

echo "minSdkVersion atualizado."

echo "Limpando projeto..."
./gradlew clean

echo "Compilando novamente..."
./gradlew assembleDebug --no-daemon

echo "======================================"
echo "BUILD CORRIGIDO"
echo "======================================"
