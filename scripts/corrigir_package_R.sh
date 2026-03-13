#!/bin/bash

echo "========================================"
echo "🔎 VERIFICAÇÃO E CORREÇÃO DO PROJETO"
echo "========================================"

PACKAGE="com.leitoruniversalia"

echo ""
echo "📦 Pacote definido:"
echo "$PACKAGE"
echo ""

# -------------------------------
# 1 Corrigir namespace Gradle
# -------------------------------

echo "⚙️ Corrigindo namespace..."

if [ -f app/build.gradle ]; then
sed -i "s/namespace .*/namespace \"$PACKAGE\"/" app/build.gradle
sed -i "s/applicationId .*/applicationId \"$PACKAGE\"/" app/build.gradle
fi

if [ -f app/build.gradle.kts ]; then
sed -i "s/namespace = .*/namespace = \"$PACKAGE\"/" app/build.gradle.kts
sed -i "s/applicationId = .*/applicationId = \"$PACKAGE\"/" app/build.gradle.kts
fi


# -------------------------------
# 2 Corrigir Manifest
# -------------------------------

echo "📄 Corrigindo AndroidManifest..."

MANIFEST=app/src/main/AndroidManifest.xml

if [ -f "$MANIFEST" ]; then
sed -i "s/package=\"[^\"]*\"/package=\"$PACKAGE\"/" $MANIFEST
fi


# -------------------------------
# 3 Corrigir MainActivity
# -------------------------------

echo "📱 Corrigindo package da MainActivity..."

find app/src/main/java -name "MainActivity.kt" -exec sed -i "1s|package .*|package $PACKAGE|" {} \;


# -------------------------------
# 4 Remover código antigo duplicado
# -------------------------------

echo "🧹 Removendo possíveis pastas antigas..."

rm -rf app/src/main/java/com/leitor/universal 2>/dev/null
rm -rf app/src/main/java/com/leitor/universalia 2>/dev/null


# -------------------------------
# 5 Garantir pasta correta
# -------------------------------

mkdir -p app/src/main/java/com/leitoruniversalia


# -------------------------------
# 6 Limpeza total do build
# -------------------------------

echo "🧹 Limpando Gradle..."

./gradlew clean


# -------------------------------
# 7 Gerar novo build
# -------------------------------

echo "🏗️ Gerando build novo..."

./gradlew assembleDebug


echo ""
echo "========================================"
echo "✅ CORREÇÃO FINALIZADA"
echo "========================================"
echo "Agora envie para o GitHub:"
echo ""
echo "git add ."
echo "git commit -m 'Correção automática de package e R'"
echo "git push origin main"
echo ""
