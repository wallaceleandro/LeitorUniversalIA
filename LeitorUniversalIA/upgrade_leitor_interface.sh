#!/bin/bash

echo "Atualizando interface do leitor..."

APP_DIR="app/src/main"

mkdir -p $APP_DIR/res/layout

cat > $APP_DIR/res/layout/activity_main.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>

<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical"
    android:padding="12dp"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

<Button
    android:id="@+id/abrirLivro"
    android:text="ABRIR LIVRO"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"/>

<Button
    android:id="@+id/biblioteca"
    android:text="BIBLIOTECA"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"/>

<Button
    android:id="@+id/historico"
    android:text="HISTÓRICO"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"/>

<TextView
    android:id="@+id/textoLivro"
    android:text="Nenhum livro aberto"
    android:textSize="18sp"
    android:layout_marginTop="10dp"
    android:layout_width="match_parent"
    android:layout_height="0dp"
    android:layout_weight="1"/>

<TextView
    android:text="Velocidade da voz"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"/>

<SeekBar
    android:id="@+id/velocidadeVoz"
    android:max="10"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"/>

<TextView
    android:text="Tom da voz"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"/>

<SeekBar
    android:id="@+id/tomVoz"
    android:max="10"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"/>

<Button
    android:id="@+id/ler"
    android:text="LER"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"/>

<Button
    android:id="@+id/pausar"
    android:text="PAUSAR"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"/>

<Button
    android:id="@+id/continuar"
    android:text="CONTINUAR"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"/>

<Button
    android:id="@+id/parar"
    android:text="PARAR"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"/>

</LinearLayout>
EOF

echo "Interface atualizada."
