#!/bin/bash
set -e

echo "======================================"
echo "INSTALANDO BIBLIOTECA DE LIVROS"
echo "======================================"

mkdir -p app/src/main/java/com/leitoruniversalia
mkdir -p app/src/main/res/layout

###################################
# LAYOUT BIBLIOTECA
###################################

cat > app/src/main/res/layout/activity_library.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>

<LinearLayout
xmlns:android="http://schemas.android.com/apk/res/android"
android:orientation="vertical"
android:layout_width="match_parent"
android:layout_height="match_parent">

<TextView
android:layout_width="match_parent"
android:layout_height="wrap_content"
android:text="Biblioteca"
android:textSize="22sp"
android:padding="10dp"/>

<ListView
android:id="@+id/bookList"
android:layout_width="match_parent"
android:layout_height="match_parent"/>

</LinearLayout>
EOF

###################################
# ACTIVITY BIBLIOTECA
###################################

cat > app/src/main/java/com/leitoruniversalia/LibraryActivity.kt << 'EOF'
package com.leitoruniversalia

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.widget.*
import android.content.SharedPreferences

class LibraryActivity:AppCompatActivity(){

lateinit var list:ListView

override fun onCreate(savedInstanceState:Bundle?){

super.onCreate(savedInstanceState)

setContentView(R.layout.activity_library)

list=findViewById(R.id.bookList)

val prefs=getSharedPreferences("books",MODE_PRIVATE)

val books=prefs.all.keys.toList()

val adapter=ArrayAdapter(this,android.R.layout.simple_list_item_1,books)

list.adapter=adapter

list.setOnItemClickListener{_,_,pos,_ ->

val book=books[pos]

val intent=Intent(this,MainActivity::class.java)

intent.putExtra("BOOK_PATH",prefs.getString(book,""))

startActivity(intent)

}

}

}
EOF

###################################
# HISTÓRICO E SALVAR LIVRO
###################################

MAIN=app/src/main/java/com/leitoruniversalia/MainActivity.kt

sed -i '/class MainActivity/a\
lateinit var prefs:android.content.SharedPreferences\
' $MAIN

sed -i '/super.onCreate/a\
prefs=getSharedPreferences("books",MODE_PRIVATE)\
' $MAIN

sed -i '/editText.setText/a\
prefs.edit().putString(uri.toString(),uri.toString()).apply()\
' $MAIN

###################################
# BOTÃO BIBLIOTECA
###################################

LAYOUT=app/src/main/res/layout/activity_main.xml

sed -i '/Spinner/i\
<Button\
android:id="@+id/buttonLibrary"\
android:layout_width="match_parent"\
android:layout_height="wrap_content"\
android:text="Biblioteca"/>\
' $LAYOUT

sed -i '/val spinner/a\
val library=findViewById<Button>(R.id.buttonLibrary)\
library.setOnClickListener{\
startActivity(Intent(this,LibraryActivity::class.java))\
}\
' $MAIN

###################################
# MANIFEST
###################################

MANIFEST=app/src/main/AndroidManifest.xml

sed -i '/<application/a\
<activity android:name=".LibraryActivity"/>' $MANIFEST

###################################
# BUILD
###################################

./gradlew clean
./gradlew assembleDebug --no-daemon

echo "======================================"
echo "BIBLIOTECA INSTALADA"
echo "======================================"
