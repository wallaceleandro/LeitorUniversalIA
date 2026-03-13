#!/bin/bash
set -e

echo "======================================"
echo "CORRIGINDO SISTEMA DE LEITURA"
echo "======================================"

FILE=app/src/main/java/com/leitoruniversalia/MainActivity.kt

echo "Removendo inserções quebradas..."

sed -i '/lateinit var prefs/d' $FILE
sed -i '/getSharedPreferences("leitor_posicao"/d' $FILE
sed -i '/texto_salvo/d' $FILE
sed -i '/posicao/d' $FILE

echo "Inserindo sistema correto..."

sed -i '/class MainActivity/a\
    private var leituraPosicao:Int=0\
    private var textoAtual:String=""\
' $FILE

echo "Corrigindo botão Ler..."

sed -i '/read.setOnClickListener/,+5c\
        read.setOnClickListener{\
            textoAtual = editText.text.toString()\
            leituraPosicao = editText.selectionStart\
            val texto = textoAtual.substring(leituraPosicao)\
            tts.speak(texto,TextToSpeech.QUEUE_FLUSH,null,null)\
        }\
' $FILE

echo "Corrigindo botão Pausar..."

sed -i '/pause.setOnClickListener/,+5c\
        pause.setOnClickListener{\
            leituraPosicao = editText.selectionStart\
            tts.stop()\
        }\
' $FILE

echo "Corrigindo botão Continuar..."

sed -i '/resume.setOnClickListener/,+5c\
        resume.setOnClickListener{\
            val texto = textoAtual.substring(leituraPosicao)\
            tts.speak(texto,TextToSpeech.QUEUE_FLUSH,null,null)\
        }\
' $FILE

echo "Limpando projeto..."
./gradlew clean

echo "Gerando APK..."
./gradlew assembleDebug --no-daemon

echo "======================================"
echo "CORREÇÃO FINALIZADA"
echo "======================================"
