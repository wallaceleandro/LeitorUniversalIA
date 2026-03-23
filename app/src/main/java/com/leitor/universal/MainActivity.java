package com.leitor.universal;

import android.app.Activity;
import android.os.Bundle;
import android.speech.tts.TextToSpeech;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends Activity {

    TextView pageInfo;
    TextToSpeech tts;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_main);

        pageInfo = findViewById(R.id.pageInfo);

        Button next = findViewById(R.id.btnNext);
        Button prev = findViewById(R.id.btnPrev);
        Button play = findViewById(R.id.btnPlay);
        Button pause = findViewById(R.id.btnPause);

        tts = new TextToSpeech(this, status -> {});
    }
}
