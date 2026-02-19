TextToSpeech tts = new TextToSpeech(context, status -> {
    tts.setLanguage(new Locale("pt","BR"));
    tts.speak(textoSelecionado, TextToSpeech.QUEUE_FLUSH, null, null);
});

// Salvar em MP3
File arquivoMP3 = new File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS) + "/APK Linux Android/" + "trecho.mp3");
tts.synthesizeToFile(textoSelecionado, null, arquivoMP3, "TTS1");
