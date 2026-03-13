#!/bin/bash
set -e

echo "======================================"
echo "ETAPA: SALVAR POSIÇÃO DE LEITURA"
echo "======================================"

FILE=app/src/main/java/com/leitoruniversalia/MainActivity.kt

echo "Inserindo sistema de salvar posição..."

sed -i '/class MainActivity/a\
    lateinit var prefs: android.content.SharedPreferences\
' $FILE

sed -i '/super.onCreate/a\
        prefs = getSharedPreferences("leitor_posicao", MODE_PRIVATE)\
' $FILE

echo "Salvando posição quando parar leitura..."

sed -i '/tts.stop()/a\
            val pos = editText.selectionStart\
            prefs.edit().putInt("posicao", pos).apply()\
            prefs.edit().putString("texto_salvo", editText.text.toString()).apply()\
' $FILE

echo "Restaurando posição ao abrir app..."

sed -i '/editText=findViewById/a\
        val textoSalvo = prefs.getString("texto_salvo", "")\
        val posicao = prefs.getInt("posicao", 0)\
        if(textoSalvo!!.isNotEmpty()){\
            editText.setText(textoSalvo)\
            editText.setSelection(posicao.coerceAtMost(textoSalvo.length))\
        }\
' $FILE

echo "Compilando projeto..."

./gradlew clean
./gradlew assembleDebug --no-daemon

echo "======================================"
echo "POSIÇÃO DE LEITURA IMPLEMENTADA"
echo "======================================"
