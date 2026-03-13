#!/bin/bash

echo "======================================"
echo "   SISTEMA COMPLETO AUTOMATIZADO"
echo "======================================"

# 1️⃣ Verificar mudanças
echo ""
echo "🔍 Verificando alterações no projeto..."
STATUS=$(git status --porcelain)

if [ -z "$STATUS" ]; then
    echo "✅ Nenhuma alteração detectada."
else
    echo "⚠️ Alterações encontradas:"
    echo "$STATUS"
fi

# 2️⃣ Limpar projeto
echo ""
echo "🧹 Limpando build..."
./gradlew clean

# 3️⃣ Incrementar versionCode automaticamente
echo ""
echo "🔢 Atualizando versão..."

BUILD_GRADLE="app/build.gradle"

VERSION_CODE=$(grep versionCode $BUILD_GRADLE | head -1 | awk '{print $2}')
NEW_VERSION_CODE=$((VERSION_CODE + 1))

sed -i "s/versionCode $VERSION_CODE/versionCode $NEW_VERSION_CODE/" $BUILD_GRADLE

echo "Nova versionCode: $NEW_VERSION_CODE"

# 4️⃣ Build do APK
echo ""
echo "📦 Gerando APK..."
./gradlew assembleDebug

# 5️⃣ Nomear APK com data e hora
DATA=$(date +"%Y%m%d-%H%M")
APK_PATH="app/build/outputs/apk/debug/app-debug.apk"
NEW_APK_NAME="Montanha-$DATA.apk"

if [ -f "$APK_PATH" ]; then
    cp "$APK_PATH" "./$NEW_APK_NAME"
    echo "✅ APK gerado: $NEW_APK_NAME"
else
    echo "❌ APK não encontrado!"
    exit 1
fi

# 6️⃣ Commit automático se houver mudanças
if [ ! -z "$STATUS" ]; then
    echo ""
    echo "📤 Enviando alterações para GitHub..."
    git add .
    git commit -m "Atualização automática - $DATA"
    git push origin main
fi

echo ""
echo "======================================"
echo "         PROCESSO FINALIZADO"
echo "======================================"
