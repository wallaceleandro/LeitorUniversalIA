#!/bin/bash

echo "======================================"
echo "INSTALANDO SUPORTE A LIVROS"
echo "PDF EPUB DOCX TXT"
echo "======================================"

BUILD=app/build.gradle

echo "Adicionando bibliotecas..."

sed -i '/dependencies {/a\    implementation "com.tom-roush:pdfbox-android:2.0.27.0"' $BUILD

sed -i '/dependencies {/a\    implementation "nl.siegmann.epublib:epublib-core:3.1"' $BUILD

sed -i '/dependencies {/a\    implementation "org.apache.poi:poi:5.2.3"' $BUILD

sed -i '/dependencies {/a\    implementation "org.apache.poi:poi-ooxml:5.2.3"' $BUILD

echo "Bibliotecas instaladas."

echo "Limpando projeto..."
./gradlew clean

echo "Compilando APK..."
./gradlew assembleDebug --no-daemon

echo "======================================"
echo "SUPORTE A LIVROS INSTALADO"
echo "======================================"
