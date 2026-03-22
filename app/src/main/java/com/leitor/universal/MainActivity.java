package com.leitor.universal;

import android.os.Bundle;
import android.speech.tts.TextToSpeech;
import android.widget.*;
import androidx.appcompat.app.AppCompatActivity;

import java.util.*;

public class MainActivity extends AppCompatActivity {

    TextToSpeech tts;
    List<String> paginas = new ArrayList<>();
    int paginaAtual = 0;

    TextView output, pageInfo;
    EditText input;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        input = findViewById(R.id.inputText);
        output = findViewById(R.id.outputText);
        pageInfo = findViewById(R.id.pageInfo);

        Button next = findViewById(R.id.btnNext);
        Button prev = findViewById(R.id.btnPrev);
        Button play = findViewById(R.id.btnPlay);
        Button pause = findViewById(R.id.btnPause);

        tts = new TextToSpeech(this, status -> {});

        next.setOnClickListener(v -> {
            if (paginaAtual < paginas.size()-1) {
                paginaAtual++;
                atualizarTela();
            }
        });

        prev.setOnClickListener(v -> {
            if (paginaAtual > 0) {
                paginaAtual--;
                atualizarTela();
            }
        });

        play.setOnClickListener(v -> {
            gerarPaginas();
            falar();
        });

        pause.setOnClickListener(v -> tts.stop());
    }

    void gerarPaginas() {
        paginas.clear();
        String texto = input.getText().toString();
        int tamanho = 200;

        for (int i = 0; i < texto.length(); i += tamanho) {
            paginas.add(texto.substring(i, Math.min(i + tamanho, texto.length())));
        }

        paginaAtual = 0;
        atualizarTela();
    }

    void atualizarTela() {
        if (paginas.size() > 0) {
            output.setText(paginas.get(paginaAtual));
            pageInfo.setText("Página " + (paginaAtual+1) + "/" + paginas.size());
        }
    }

    void falar() {
        if (paginas.size() > 0) {
            tts.speak(paginas.get(paginaAtual), TextToSpeech.QUEUE_FLUSH, null, null);
        }
    }
}
