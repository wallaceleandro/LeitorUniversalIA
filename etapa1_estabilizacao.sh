#!/bin/bash

echo "======================================"
echo " ETAPA 1 - ESTABILIZACAO DO LEITOR"
echo "======================================"

# Garantir permissão do Gradle
if [ -f "./gradlew" ]; then
    echo "Dando permissão ao gradlew..."
    chmod +x gradlew
fi

# Limpeza total do projeto
echo "Limpando projeto..."
./gradlew clean

# Atualizando dependências
echo "Sincronizando dependências..."
./gradlew build --refresh-dependencies

# Build completo
echo "Executando build..."
./gradlew assembleDebug

# Verificação final
if [ $? -eq 0 ]; then
    echo "======================================"
    echo " ETAPA 1 CONCLUIDA COM SUCESSO ✅"
    echo "======================================"
else
    echo "======================================"
    echo " ERRO NA ETAPA 1 ❌"
    echo " Verifique os logs acima."
    echo "======================================"
fi
