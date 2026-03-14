#!/bin/bash

echo "======================================"
echo "SISTEMA DE VERIFICAÇÃO + BACKUP"
echo "======================================"

DATA=$(date +"%Y%m%d_%H%M%S")

BACKUP_DIR="backup_$DATA"
mkdir -p $BACKUP_DIR

echo "Criando backup..."

cp -r app/src $BACKUP_DIR/
cp app/build.gradle $BACKUP_DIR/ 2>/dev/null
cp AndroidManifest.xml $BACKUP_DIR/ 2>/dev/null

echo "Backup salvo em: $BACKUP_DIR"

echo "======================================"
echo "Verificando estrutura..."
echo "======================================"

if [ ! -f "app/build.gradle" ]; then
    echo "ERRO: build.gradle não encontrado!"
    exit 1
fi

if [ ! -d "app/src" ]; then
    echo "ERRO: pasta src não encontrada!"
    exit 1
fi

echo "======================================"
echo "Limpando projeto..."
echo "======================================"

./gradlew clean

echo "======================================"
echo "Compilando projeto..."
echo "======================================"

./gradlew build

echo "======================================"
echo "VERIFICAÇÃO CONCLUÍDA"
echo "======================================"
