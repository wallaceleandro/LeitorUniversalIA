#!/bin/bash

echo "======================================"
echo "ETAPA ZERO - SISTEMA DE SEGURANÇA"
echo "BACKUP + VERIFICAÇÃO + LIMPEZA"
echo "======================================"

DATA=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="BACKUP_ETAPA0_$DATA"

echo "Criando pasta de backup..."
mkdir -p $BACKUP_DIR

echo "Fazendo backup dos arquivos principais..."

cp -r app/src $BACKUP_DIR/ 2>/dev/null
cp app/build.gradle $BACKUP_DIR/ 2>/dev/null
cp AndroidManifest.xml $BACKUP_DIR/ 2>/dev/null

echo "Backup concluído em: $BACKUP_DIR"

echo "======================================"
echo "Verificando estrutura do projeto..."
echo "======================================"

if [ ! -d "app/src" ]; then
    echo "ERRO: Pasta app/src não encontrada!"
    exit 1
fi

if [ ! -f "app/build.gradle" ]; then
    echo "ERRO: build.gradle não encontrado!"
    exit 1
fi

echo "Estrutura OK."

echo "======================================"
echo "Limpando projeto..."
echo "======================================"

./gradlew clean

echo "======================================"
echo "Testando build..."
echo "======================================"

./gradlew build --no-daemon

echo "======================================"
echo "ETAPA ZERO CONCLUÍDA COM SUCESSO"
echo "Projeto protegido."
echo "======================================"
