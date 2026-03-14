#!/bin/bash

set -e

echo "======================================"
echo " ETAPA 3 - INTERFACE DO LEITOR"
echo "======================================"

LOGFILE="etapa3_build.log"

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
echo "2 - Criando estrutura da interface do leitor..."

mkdir -p app/src/main/java/modules/leitor/ui
mkdir -p app/src/main/res/layout/modules/leitor

echo ""
echo "3 - Criando layout base do leitor..."

LAYOUT_FILE="app/src/main/res/layout/modules/leitor/activity_leitor.xml"

if [ ! -f "$LAYOUT_FILE" ]; then

cat << 'EOF' > $LAYOUT_FILE
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp">

    <TextView
        android:id="@+id/tituloLeitor"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Leitor Universal IA"
        android:textSize="22sp"
        android:textStyle="bold"
        android:paddingBottom="16dp"/>

    <ScrollView
        android:layout_width="match_parent"
        android:layout_height="match_parent">

        <TextView
            android:id="@+id/textoConteudo"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="Conteúdo do texto aparecerá aqui."
            android:textSize="16sp"/>

    </ScrollView>

</LinearLayout>
EOF

echo "Layout criado."

else

echo "Layout já existe."

fi

echo ""
echo "4 - Limpando projeto..."

./gradlew clean --no-daemon

echo ""
echo "5 - Executando build..."

./gradlew assembleDebug --no-daemon

echo ""
echo "======================================"
echo " ETAPA 3 FINALIZADA ✅"
echo " Interface base do leitor criada"
echo "======================================"
