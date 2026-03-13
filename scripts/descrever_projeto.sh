.#!/bin/bash
# =============================================
# Script para descrever todas as funções e pastas
# do projeto LeitorUniversalIA
# =============================================

PROJETO_DIR=$(pwd)
OUTPUT_FILE="resumo_projeto.txt"

echo "Gerando resumo do projeto em: $OUTPUT_FILE"
echo "Projeto: $PROJETO_DIR" > $OUTPUT_FILE
echo "Data: $(date)" >> $OUTPUT_FILE
echo "=========================================" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# 1️⃣ Listar toda a estrutura de pastas e arquivos
echo ">> Estrutura de pastas e arquivos:" >> $OUTPUT_FILE
tree -a -L 3 -h --dirsfirst >> $OUTPUT_FILE 2>/dev/null || find . -maxdepth 3 -exec ls -lh {} \; >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# 2️⃣ Listar scripts shell (.sh) do projeto
echo ">> Scripts shell (.sh) encontrados:" >> $OUTPUT_FILE
find . -type f -name "*.sh" -exec ls -lh {} \; >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# 3️⃣ Listar arquivos Gradle
echo ">> Arquivos Gradle (.gradle e gradlew):" >> $OUTPUT_FILE
find . -type f \( -name "*.gradle" -o -name "gradlew*" \) -exec ls -lh {} \; >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# 4️⃣ Listar arquivos de configuração importantes
echo ">> Arquivos de configuração (.properties, .yml, .yaml, settings.gradle):" >> $OUTPUT_FILE
find . -type f \( -name "*.properties" -o -name "*.yml" -o -name "*.yaml" -o -name "settings.gradle" \) -exec ls -lh {} \; >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# 5️⃣ Resumo de permissões executáveis
echo ">> Arquivos com permissão de execução:" >> $OUTPUT_FILE
find . -type f -perm /u=x,g=x,o=x -exec ls -lh {} \; >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# 6️⃣ Estatísticas gerais
echo ">> Estatísticas gerais:" >> $OUTPUT_FILE
TOTAL_FILES=$(find . -type f | wc -l)
TOTAL_DIRS=$(find . -type d | wc -l)
echo "Total de arquivos: $TOTAL_FILES" >> $OUTPUT_FILE
echo "Total de pastas: $TOTAL_DIRS" >> $OUTPUT_FILE

echo ""
echo "Resumo gerado em $OUTPUT_FILE"
