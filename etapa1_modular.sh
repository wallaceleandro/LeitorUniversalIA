#!/bin/bash

echo "======================================"
echo " ETAPA 1 - ESTRUTURA MODULAR DO PROJETO"
echo "======================================"

# Verificar se está na raiz do projeto
if [ ! -f "./gradlew" ]; then
    echo "ERRO: gradlew nao encontrado."
    echo "Execute este script na raiz do projeto."
    exit 1
fi

echo "Configurando permissao do gradlew..."
chmod +x gradlew

echo "Criando estrutura modular..."

mkdir -p app/src/main/java/modules/cnh
mkdir -p app/src/main/java/modules/leitor
mkdir -p app/src/main/java/modules/config
mkdir -p app/src/main/res/layout/modules

echo "Limpando projeto..."
./gradlew clean

echo "Atualizando dependencias..."
./gradlew build --refresh-dependencies

echo "Build de verificacao..."
./gradlew assembleDebug

if [ $? -eq 0 ]; then
    echo "======================================"
    echo " ETAPA 1 CONCLUIDA COM SUCESSO ✅"
    echo "======================================"
else
    echo "======================================"
    echo " ERRO NA ETAPA 1 ❌"
    echo "======================================"
    exit 1
fi
