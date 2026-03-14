#!/bin/bash

echo "======================================"
echo " ETAPA 2 - TXT FUNCIONAL"
echo "======================================"

# Verificar gradlew
if [ ! -f "./gradlew" ]; then
    echo "ERRO: Execute na raiz do projeto."
    exit 1
fi

chmod +x gradlew

# Criar estrutura do leitor TXT
echo "Criando estrutura do modulo Leitor..."

mkdir -p app/src/main/java/modules/leitor/txt
mkdir -p app/src/main/java/modules/leitor/core
mkdir -p app/src/main/res/layout/modules/leitor

# Limpeza
echo "Limpando projeto..."
./gradlew clean

# Atualizar dependencias
echo "Atualizando dependencias..."
./gradlew build --refresh-dependencies

# Build
echo "Executando build..."
./gradlew assembleDebug

if [ $? -eq 0 ]; then
    echo "======================================"
    echo " ETAPA 2 CONCLUIDA COM SUCESSO ✅"
    echo " TXT estruturado e pronto para implementacao."
    echo "======================================"
else
    echo "======================================"
    echo " ERRO NA ETAPA 2 ❌"
    echo "======================================"
    exit 1
fi
