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
