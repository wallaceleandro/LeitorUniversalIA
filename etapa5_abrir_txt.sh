#!/bin/bash

set -e

echo "======================================"
echo " ETAPA 5 - ABRIR ARQUIVO TXT"
echo "======================================"

LOGFILE="etapa5_build.log"

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
echo "2 - Criando Activity do leitor..."

JAVA_FILE="app/src/main/java/modules/leitor/ui/LeitorActivity.java"

mkdir -p app/src/main/java/modules/leitor/ui

if [ ! -f "$JAVA_FILE" ]; then

cat << 'EOF' > $JAVA_FILE
package modules.leitor.ui;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;

import androidx.annotation.Nullable;

import java.io.File;

import modules.leitor.txt.LeitorTXT;

public class LeitorActivity extends Activity {

    private static final int REQUEST_CODE = 1001;

    TextView textoConteudo;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.modules.leitor.activity_leitor);

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
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {

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

echo "Activity do leitor criada."

else

echo "Activity já existe."

fi

echo ""
echo "3 - Atualizando layout do leitor..."

LAYOUT_FILE="app/src/main/res/layout/modules/leitor/activity_leitor.xml"

cat << 'EOF' > $LAYOUT_FILE
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

echo "Layout atualizado."

echo ""
echo "4 - Limpando projeto..."

./gradlew clean --no-daemon

echo ""
echo "5 - Executando build..."

./gradlew assembleDebug --no-daemon

echo ""
echo "======================================"
echo " ETAPA 5 FINALIZADA ✅"
echo " Leitor agora pode abrir arquivos TXT"
echo "======================================"
