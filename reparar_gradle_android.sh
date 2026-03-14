#!/bin/bash

set -e

LOGFILE="reparo_build.log"

echo "======================================"
echo " REPARO COMPLETO DO AMBIENTE ANDROID"
echo "======================================"

echo "Log será salvo em: $LOGFILE"
echo ""

exec > >(tee -i $LOGFILE)
exec 2>&1

echo "1 - Removendo caches do Gradle..."

rm -rf ~/.gradle/caches
rm -rf ~/.gradle/daemon
rm -rf ~/.gradle/native
rm -rf ~/.gradle/wrapper

echo "Caches do Gradle removidos."

echo ""
echo "2 - Limpando projeto..."

rm -rf .gradle
rm -rf app/build
rm -rf build

echo "Build antigo removido."

echo ""
echo "3 - Verificando gradlew..."

if [ ! -f "./gradlew" ]; then
    echo "ERRO: gradlew nao encontrado."
    exit 1
fi

chmod +x gradlew

echo ""
echo "4 - Executando limpeza..."

./gradlew clean --no-daemon

echo ""
echo "5 - Baixando dependencias novamente..."

./gradlew build --refresh-dependencies --no-daemon

echo ""
echo "6 - Build final..."

./gradlew assembleDebug --no-daemon

echo ""
echo "======================================"
echo " BUILD REPARADO COM SUCESSO ✅"
echo "======================================"
