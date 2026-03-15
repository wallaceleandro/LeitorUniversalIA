#!/bin/bash

echo "================================="
echo "CORRIGINDO PACOTE DO PROJETO"
echo "================================="

SRC="app/src/main/java"

echo "1 - Criando pacote correto..."

mkdir -p $SRC/com/leitor/universal

echo "2 - Movendo arquivos..."

mv $SRC/com/leitoruniversalia/*.kt $SRC/com/leitor/universal/ 2>/dev/null

echo "3 - Removendo pacote antigo..."

rm -rf $SRC/com/leitoruniversalia

echo "4 - Corrigindo package nos arquivos..."

find $SRC -name "*.kt" -exec sed -i 's/com.leitoruniversalia/com.leitor.universal/g' {} +

echo "5 - Corrigindo AndroidManifest..."

sed -i 's/com.leitoruniversalia/com.leitor.universal/g' app/src/main/AndroidManifest.xml

echo "================================="
echo "PACOTE CORRIGIDO"
echo "================================="
