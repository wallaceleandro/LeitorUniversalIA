#!/bin/bash

echo "======================================"
echo "🔧 CORREÇÃO AUTOMÁTICA DO PROJETO"
echo "======================================"

PACKAGE="com.leitoruniversalia"
JAVA_DIR="app/src/main/java"

echo ""
echo "📦 Pacote oficial do projeto:"
echo "$PACKAGE"
echo ""

# -----------------------------------
# 1 Remover duplicação de MainActivity
# -----------------------------------

echo "🔎 Procurando MainActivity duplicadas..."

FILES=$(find $JAVA_DIR -name "MainActivity.kt")

COUNT=$(echo "$FILES" | wc -l)

if [ "$COUNT" -gt 1 ]; then
    echo "⚠️ Encontradas várias MainActivity"
    echo "$FILES"

    echo ""
    echo "🧹 Removendo versão antiga..."

    rm -rf app/src/main/java/com/leitor/universal 2>/dev/null
    rm -rf app/src/main/java/com/leitor/universalia 2>/dev/null

    echo "✅ Pasta duplicada removida"
else
    echo "✅ Apenas uma MainActivity encontrada"
fi

# -----------------------------------
# 2 Garantir pasta correta
# -----------------------------------

mkdir -p app/src/main/java/com/leitoruniversalia

# -----------------------------------
# 3 Corrigir package da MainActivity
# -----------------------------------

echo "📱 Corrigindo package da MainActivity..."

find app/src/main/java -name "MainActivity.kt" \
-exec sed -i "1s|package .*|package $PACKAGE|" {} \;

# -----------------------------------
# 4 Corrigir build.gradle
# -----------------------------------

echo "⚙️ Corrigindo namespace..."

if [ -f app/build.gradle ]; then
sed -i "s/namespace .*/namespace \"$PACKAGE\"/" app/build.gradle
sed -i "s/applicationId .*/applicationId \"$PACKAGE\"/" app/build.gradle
fi

if [ -f app/build.gradle.kts ]; then
sed -i "s/namespace = .*/namespace = \"$PACKAGE\"/" app/build.gradle.kts
sed -i "s/applicationId = .*/applicationId = \"$PACKAGE\"/" app/build.gradle.kts
fi

# -----------------------------------
# 5 Corrigir AndroidManifest
# -----------------------------------

MANIFEST=app/src/main/AndroidManifest.xml

if [ -f "$MANIFEST" ]; then
echo "📄 Corrigindo AndroidManifest..."
sed -i "s/package=\"[^\"]*\"/package=\"$PACKAGE\"/" $MANIFEST
fi

# -----------------------------------
# 6 Verificar layout principal
# -----------------------------------

LAYOUT=app/src/main/res/layout/activity_main.xml

if [ ! -f "$LAYOUT" ]; then
echo "⚠️ Layout não encontrado. Criando novo..."

mkdir -p app/src/main/res/layout

cat > $LAYOUT <<EOF
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
android:orientation="vertical"
android:layout_width="match_parent"
android:layout_height="match_parent"
android:gravity="center"
android:padding="20dp">

<EditText
android:id="@+id/editText"
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:hint="Digite o texto"/>

<Button
android:id="@+id/buttonRead"
android:layout_width="wrap_content"
android:layout_height="wrap_content"
android:text="Ler em voz alta"/>

</LinearLayout>
EOF

echo "✅ Layout recriado"
else
echo "✅ Layout encontrado"
fi

# -----------------------------------
# 7 Limpar Gradle
# -----------------------------------

echo ""
echo "🧹 Limpando Gradle..."

./gradlew clean || true

rm -rf .gradle
rm -rf ~/.gradle/caches

# -----------------------------------
# 8 Gerar novo build
# -----------------------------------

echo ""
echo "🏗️ Gerando build..."

./gradlew assembleDebug

echo ""
echo "======================================"
echo "✅ PROJETO CORRIGIDO"
echo "======================================"
echo ""

echo "Agora envie para o GitHub:"
echo ""
echo "git add ."
echo "git commit -m 'Correção automática do projeto'"
echo "git push origin main"
echo ""
