#!/bin/bash

set -e

echo "======================================"
echo " CORRECAO ETAPA 5 - LEITOR TXT"
echo "======================================"

LOGFILE="etapa5_correcao.log"

exec > >(tee -i $LOGFILE)
exec 2>&1

echo ""
echo "1 - Corrigindo estrutura de layout..."

mkdir -p app/src/main/res/layout

if [ -f app/src/main/res/layout/modules/leitor/activity_leitor.xml ]; then
    mv app/src/main/res/layout/modules/leitor/activity_leitor.xml \
       app/src/main/res/layout/activity_leitor.xml
fi

rm -rf app/src/main/res/layout/modules

echo "Layout movido."

echo ""
echo "2 - Corrigindo Activity..."

cat << 'EOF' > app/src/main/java/modules/leitor/ui/LeitorActivity.java
package com.leitoruniversalia.modules.leitor.ui;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;

import java.io.File;

import com.leitoruniversalia.modules.leitor.txt.LeitorTXT;
import com.leitoruniversalia.R;

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

echo "Activity corrigida."

echo ""
echo "3 - Limpando projeto..."

./gradlew clean --no-daemon

echo ""
echo "4 - Build novamente..."

./gradlew assembleDebug --no-daemon

echo ""
echo "======================================"
echo " CORRECAO FINALIZADA ✅"
echo "======================================"
