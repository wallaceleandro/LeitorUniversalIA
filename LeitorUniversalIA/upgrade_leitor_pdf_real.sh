#!/bin/bash

echo "===================================="
echo "ATUALIZANDO LEITOR COM SUPORTE PDF"
echo "===================================="

APP="app/src/main"

echo "1 - Atualizando AndroidManifest..."

cat > $APP/AndroidManifest.xml << 'EOF'
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.leitoruniversalia">

<application
    android:allowBackup="true"
    android:label="Leitor Universal IA"
    android:theme="@style/Theme.AppCompat.Light.DarkActionBar">

<activity android:name=".LeitorActivity" />

<activity android:name=".MainActivity">

<intent-filter>

<action android:name="android.intent.action.MAIN" />

<category android:name="android.intent.category.LAUNCHER" />

</intent-filter>

</activity>

</application>

</manifest>
EOF

echo "2 - Criando nova interface principal..."

mkdir -p $APP/res/layout

cat > $APP/res/layout/activity_main.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>

<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
android:orientation="vertical"
android:padding="20dp"
android:layout_width="match_parent"
android:layout_height="match_parent">

<Button
android:id="@+id/abrirPDF"
android:text="ABRIR PDF"
android:layout_width="match_parent"
android:layout_height="wrap_content"/>

<Button
android:id="@+id/biblioteca"
android:text="BIBLIOTECA"
android:layout_width="match_parent"
android:layout_height="wrap_content"/>

<Button
android:id="@+id/historico"
android:text="HISTÓRICO"
android:layout_width="match_parent"
android:layout_height="wrap_content"/>

</LinearLayout>
EOF

echo "3 - Criando MainActivity real..."

mkdir -p $APP/java/com/leitoruniversalia

cat > $APP/java/com/leitoruniversalia/MainActivity.kt << 'EOF'
package com.leitoruniversalia

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

override fun onCreate(savedInstanceState: Bundle?) {

super.onCreate(savedInstanceState)

setContentView(R.layout.activity_main)

val abrir = findViewById<Button>(R.id.abrirPDF)

abrir.setOnClickListener {

val intent = Intent(this, LeitorActivity::class.java)

startActivity(intent)

}

}
}
EOF

echo "4 - Criando layout do leitor..."

cat > $APP/res/layout/activity_leitor.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>

<com.github.barteksc.pdfviewer.PDFView
xmlns:android="http://schemas.android.com/apk/res/android"
android:id="@+id/pdfView"
android:layout_width="match_parent"
android:layout_height="match_parent"/>
EOF

echo "5 - Criando LeitorActivity..."

cat > $APP/java/com/leitoruniversalia/LeitorActivity.kt << 'EOF'
package com.leitoruniversalia

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.github.barteksc.pdfviewer.PDFView

class LeitorActivity : AppCompatActivity() {

override fun onCreate(savedInstanceState: Bundle?) {

super.onCreate(savedInstanceState)

setContentView(R.layout.activity_leitor)

val pdfView = findViewById<PDFView>(R.id.pdfView)

pdfView.fromAsset("livro.pdf")
.enableSwipe(true)
.enableDoubletap(true)
.load()

}
}
EOF

echo "===================================="
echo "LEITOR PDF INSTALADO"
echo "===================================="

echo "Funções:"
echo "✔ abrir PDF"
echo "✔ navegar páginas"
echo "✔ zoom"
echo "✔ swipe de páginas"

echo "Script finalizado."
