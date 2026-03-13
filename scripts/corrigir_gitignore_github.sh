#!/bin/bash
set -e

echo "======================================"
echo "CORRIGINDO GITIGNORE DO PROJETO"
echo "======================================"

PROJECT=~/LeitorUniversalIA

cd $PROJECT

echo "Criando .gitignore..."

cat > .gitignore << 'EOF'
# Gradle
.gradle/
build/

# Android build
app/build/
local.properties

# Logs
*.log

# IDE
.idea/
*.iml

# APK / Bundle
*.apk
*.aab
EOF

echo ".gitignore criado."

echo "Removendo arquivos de build do controle do Git..."

git rm -r --cached .gradle 2>/dev/null || true
git rm -r --cached app/build 2>/dev/null || true

echo "Organizando scripts..."

mkdir -p scripts

for f in *.sh; do
    if [ -f "$f" ]; then
        mv "$f" scripts/ 2>/dev/null || true
    fi
done

echo "Adicionando arquivos ao Git..."

git add .

echo "Criando commit..."

git commit -m "Correção gitignore + limpeza arquivos de build + organização scripts"

echo "Enviando para GitHub..."

git push origin main

echo "======================================"
echo "GIT CORRIGIDO E PROJETO ENVIADO"
echo "======================================"
