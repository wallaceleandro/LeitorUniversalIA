#!/bin/bash

set -e

echo "======================================"
echo " ETAPA 4 - SISTEMA DE LEITURA TXT"
echo "======================================"

LOGFILE="etapa4_build.log"

exec > >(tee -i $LOGFILE)
exec 2>&1

echo ""
echo "1 - Verificando gradlew..."

if [ ! -f "./gradlew" ]; then
    echo "ERRO: Execute o script na raiz do projeto."
    exit 1
fi

chmod +x gradlew

echo ""
echo "2 - Criando classe de leitura TXT..."

JAVA_FILE="app/src/main/java/modules/leitor/txt/LeitorTXT.java"

mkdir -p app/src/main/java/modules/leitor/txt

if [ ! -f "$JAVA_FILE" ]; then

cat << 'EOF' > $JAVA_FILE
package modules.leitor.txt;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

public class LeitorTXT {

    public static String lerArquivo(File arquivo) {

        StringBuilder texto = new StringBuilder();

        try {

            BufferedReader reader = new BufferedReader(new FileReader(arquivo));
            String linha;

            while ((linha = reader.readLine()) != null) {
                texto.append(linha);
                texto.append("\n");
            }

            reader.close();

        } catch (Exception e) {
            return "Erro ao ler arquivo: " + e.getMessage();
        }

        return texto.toString();
    }
}
EOF

echo "Classe de leitura TXT criada."

else

echo "Classe já existe."

fi

echo ""
echo "3 - Limpando projeto..."

./gradlew clean --no-daemon

echo ""
echo "4 - Executando build..."

./gradlew assembleDebug --no-daemon

echo ""
echo "======================================"
echo " ETAPA 4 FINALIZADA ✅"
echo " Sistema de leitura TXT preparado"
echo "======================================"
