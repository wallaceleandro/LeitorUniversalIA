package com.leitoruniversal.ia;

import android.content.Context;
import android.os.Environment;
import android.speech.tts.TextToSpeech;
import java.io.File;
import java.util.Locale;

public class LeitorAudio {

    public static void salvarTrechoEmAudio(Context context, String textoSelecionado) {
        TextToSpeech tts = new TextToSpeech(context, status -> {
            if (status == TextToSpeech.SUCCESS) {
                tts.setLanguage(new Locale("pt","BR"));
                
                File arquivoMP3 = new File(Environment.getExternalStoragePublicDirectory(
                    Environment.DIRECTORY_DOWNLOADS) + "/APK Linux Android/trecho.mp3"
                );
                
                tts.synthesizeToFile(textoSelecionado, null, arquivoMP3, "TTS1");
            }
        });
    }
}
