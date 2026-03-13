#!/bin/bash

echo "======================================"
echo "        TESTE COMPLETO DO PROJETO"
echo "======================================"

echo ""
echo "📌 Verificando status do Git..."
git status

echo ""
echo "📌 Verificando arquivos modificados..."
MODIFICADOS=$(git ls-files -m)

if [ -z "$MODIFICADOS" ]; then
    echo "✅ Nenhum arquivo foi modificado."
else
    echo "⚠️ Arquivos modificados encontrados:"
    echo "$MODIFICADOS"
fi

echo ""
echo "📌 Verificando arquivos não rastreados..."
NOVOS=$(git ls-files --others --exclude-standard)

if [ -z "$NOVOS" ]; then
    echo "✅ Nenhum arquivo novo."
else
    echo "⚠️ Arquivos novos encontrados:"
    echo "$NOVOS"
fi

echo ""
echo "📌 Último commit:"
git log -1 --oneline

echo ""
echo "📌 Verificando se está sincronizado com o GitHub..."
git fetch

LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})
BASE=$(git merge-base @ @{u})

if [ "$LOCAL" = "$REMOTE" ]; then
    echo "✅ Projeto está 100% sincronizado com o GitHub."
elif [ "$LOCAL" = "$BASE" ]; then
    echo "⚠️ Você NÃO enviou alterações para o GitHub."
elif [ "$REMOTE" = "$BASE" ]; then
    echo "⚠️ O GitHub tem alterações que você não baixou."
else
    echo "⚠️ Branches divergiram."
fi

echo ""
echo "======================================"
echo "            FIM DO TESTE"
echo "======================================"
