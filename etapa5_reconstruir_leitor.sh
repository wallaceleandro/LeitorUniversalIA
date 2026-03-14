#!/bin/bash

set -e

echo "======================================"
echo " RECONSTRUINDO MODULO LEITOR"
echo "======================================"

echo ""
echo "1 - Removendo arquivos quebrados..."

rm -rf app/src/main/java/modules/leitor
rm -rf app/src/main/res/layout/modules

echo "Arquivos antigos removidos."

echo ""
echo "2 - Criando estrutura correta..."

mkdir -p app/src/main/java/com/leitoruniversalia/modules/leitor/ui
mkdir -p app/src/main/java/com/leitoruniversalia/modules/leitor/txt
mkdir -p app/src/main/res/layout

echo ""
echo "3 - Criando classe LeitorTXT..."

cat << 'EOF' > app/src/main/java/com/leitoruniversalia/modules/leitor/txt/LeitorTXT.java
package com.leitoruniversalia.modules.leitor.txt;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

public class LeitorTXT {

    public static String lerArquivo(File arquivo) {

        StringBuilder conteudo = new StringBuilder();

        try {

            BufferedReader reader = new BufferedReader(new FileReader(arquivo));
            String linha;

            while ((linha = reader.readLine()) != null) {
                conteudo.append(linha).append("\n");
            }

            reader.close();

        } catch (Exception e) {
            return "Erro ao ler arquivo.";
        }

        return conteudo.toString();
    }
}
EOF

echo "LeitorTXT criado."

echo ""
echo "4 - Criando Activity do leitor..."

cat << 'EOF' > app/src/main/java/com/leitoruniversalia/modules/leitor/ui/LeitorActivity.java
package com.leitoruniversalia.modules.leitor.ui;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;

import com.leitoruniversalia.R;
import com.leitoruniversalia.modules.leitor.txt.LeitorTXT;

import java.io.File;

public class LeitorActivity extends Activity {

    private static final int REQUEST_CODE = 1001;

    TextView textoConteudo;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_leitor);

        Button abrirArquivo = findViewById(R.id.botaoAbrirArquivo);
        textoConteudo = findViewById(R.id.textoConteudo);

        abrirArquivo.setOnClickListener(v -> abrirArquivo());
    }

    private void abrirArquivo() {

        Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
        intent.setType("text/plain");

        startActivityForResult(intent, REQUEST_CODE);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {

        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == REQUEST_CODE && resultCode == RESULT_OK && data != null) {

            Uri uri = data.getData();

            if (uri != null) {

                File arquivo = new File(uri.getPath());

                String texto = LeitorTXT.lerArquivo(arquivo);

                textoConteudo.setText(texto);
            }
        }
    }
}
EOF

echo "Activity criada."

echo ""
echo "5 - Criando layout..."

cat << 'EOF' > app/src/main/res/layout/activity_leitor.xml
<?xml version="1.0" encoding="utf-8"?>

<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp">

    <Button
        android:id="@+id/botaoAbrirArquivo"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Abrir arquivo TXT"/>

    <ScrollView
        android:layout_width="match_parent"
        android:layout_height="match_parent">

        <TextView
            android:id="@+id/textoConteudo"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="Nenhum arquivo carregado."
            android:textSize="16sp"/>

    </ScrollView>

</LinearLayout>
EOF

echo "Layout criado."

echo ""
echo "6 - Limpando projeto..."

./gradlew clean --no-daemon

echo ""
echo "7 - Build novamente..."

./gradlew assembleDebug --no-daemon

echo ""
echo "======================================"
echo " LEITOR RECONSTRUIDO COM SUCESSO"
echo "======================================"
