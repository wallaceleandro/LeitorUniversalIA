#!/bin/bash

echo "======================================"
echo "CORRIGINDO DEPENDÊNCIAS DO LEITOR"
echo "======================================"

BUILD=app/build.gradle

echo "Removendo biblioteca EPUB inválida..."

sed -i '/epublib-core/d' $BUILD

echo "Garantindo dependências corretas..."

sed -i '/dependencies {/a\    implementation "com.tom-roush:pdfbox-android:2.0.27.0"' $BUILD
sed -i '/dependencies {/a\    implementation "org.apache.poi:poi:5.2.3"' $BUILD
sed -i '/dependencies {/a\    implementation "org.apache.poi:poi-ooxml:5.2.3"' $BUILD

echo "Limpando projeto..."
./gradlew clean

echo "Gerando APK..."
./gradlew assembleDebug --no-daemon

echo "======================================"
echo "DEPENDÊNCIAS CORRIGIDAS"
echo "======================================"
