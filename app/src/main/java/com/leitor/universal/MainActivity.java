package com.leitor.universal;

import android.app.Activity;
import android.os.Bundle;
import android.widget.*;
import android.speech.tts.TextToSpeech;
import android.content.Intent;
import android.net.Uri;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Locale;

public class MainActivity extends Activity {

    TextView textContent;
    TextToSpeech tts;

    float speed = 1.0f;
    float pitch = 1.0f;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        textContent = findViewById(R.id.textContent);
        Button open = findViewById(R.id.btnOpen);
        Button play = findViewById(R.id.btnPlay);
        Button pause = findViewById(R.id.btnPause);

        SeekBar seekSpeed = findViewById(R.id.seekSpeed);
        SeekBar seekPitch = findViewById(R.id.seekPitch);

        tts = new TextToSpeech(this, status -> {
            if (status == TextToSpeech.SUCCESS) {
                tts.setLanguage(new Locale("pt", "BR"));
            }
        });

        open.setOnClickListener(v -> {
            Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
            intent.setType("text/plain");
            startActivityForResult(intent, 1);
        });

        play.setOnClickListener(v -> {
            tts.setSpeechRate(speed);
            tts.setPitch(pitch);
            tts.speak(textContent.getText().toString(),
                    TextToSpeech.QUEUE_FLUSH, null, null);
        });

        pause.setOnClickListener(v -> {
            tts.stop();
        });

        seekSpeed.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                speed = progress / 100f;
                if (speed < 0.5f) speed = 0.5f;
            }
            public void onStartTrackingTouch(SeekBar seekBar) {}
            public void onStopTrackingTouch(SeekBar seekBar) {}
        });

        seekPitch.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                pitch = progress / 100f;
                if (pitch < 0.5f) pitch = 0.5f;
            }
            public void onStartTrackingTouch(SeekBar seekBar) {}
            public void onStopTrackingTouch(SeekBar seekBar) {}
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == 1 && resultCode == RESULT_OK) {
            try {
                Uri uri = data.getData();
                BufferedReader reader = new BufferedReader(
                        new InputStreamReader(getContentResolver().openInputStream(uri))
                );

                StringBuilder text = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    text.append(line).append("\n");
                }

                textContent.setText(text.toString());

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        super.onActivityResult(requestCode, resultCode, data);
    }
}
