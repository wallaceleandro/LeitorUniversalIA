#!/bin/bash
set -e

echo "======================================"
echo "CORRIGINDO PERMISSÕES E SAF"
echo "======================================"

MANIFEST=app/src/main/AndroidManifest.xml

echo "Adicionando permissões de leitura..."

sed -i '/<manifest/a\
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>' $MANIFEST

echo "Ativando SAF no código..."

FILE=app/src/main/java/com/leitoruniversalia/MainActivity.kt

sed -i 's/intent.type="text\/\*"/intent.type="*\/\*"/' $FILE

sed -i '/startActivityForResult/i\
intent.addCategory(Intent.CATEGORY_OPENABLE)' $FILE

echo "Permissões corrigidas."

./gradlew clean
./gradlew assembleDebug --no-daemon

echo "======================================"
echo "PERMISSÕES CORRIGIDAS"
echo "======================================"
