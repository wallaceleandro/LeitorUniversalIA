#!/bin/bash
set -e

echo "======================================"
echo "RECRIANDO LAYOUT DO LEITOR"
echo "======================================"

LAYOUT=app/src/main/res/layout/activity_main.xml

cat > $LAYOUT << 'EOF'
<?xml version="1.0" encoding="utf-8"?>

<LinearLayout
xmlns:android="http://schemas.android.com/apk/res/android"
android:orientation="vertical"
android:padding="16dp"
android:layout_width="match_parent"
android:layout_height="match_parent">

<Button
    android:id="@+id/btnAbrir"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:text="Abrir Livro"/>

<EditText
    android:id="@+id/editText"
    android:layout_width="match_parent"
    android:layout_height="0dp"
    android:layout_weight="1"
    android:gravity="top"
    android:hint="Texto do livro aparecerá aqui"
    android:inputType="textMultiLine"/>

<Button
    android:id="@+id/btnLer"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:text="Ler"/>

<Button
    android:id="@+id/btnPausar"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:text="Pausar"/>

<Button
    android:id="@+id/btnContinuar"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:text="Continuar"/>

<Button
    android:id="@+id/btnParar"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:text="Parar"/>

</LinearLayout>
EOF

echo "Layout recriado."

echo "Limpando projeto..."
./gradlew clean

echo "Gerando APK..."
./gradlew assembleDebug --no-daemon

echo "======================================"
echo "LAYOUT CORRIGIDO"
echo "======================================"
