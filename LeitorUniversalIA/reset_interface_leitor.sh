#!/bin/bash

echo "=================================="
echo "RESETANDO INTERFACE DO APP"
echo "=================================="

APP="app/src/main"

echo "1 - Limpando layouts antigos..."

rm -f $APP/res/layout/*.xml

mkdir -p $APP/res/layout

echo "2 - Criando interface nova..."

cat > $APP/res/layout/activity_main.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>

<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
android:orientation="vertical"
android:gravity="center"
android:padding="24dp"
android:layout_width="match_parent"
android:layout_height="match_parent">

<TextView
android:text="Leitor Universal IA"
android:textSize="24sp"
android:layout_marginBottom="30dp"
android:layout_width="wrap_content"
android:layout_height="wrap_content"/>

<Button
android:id="@+id/abrirPDF"
android:text="Abrir PDF"
android:layout_width="match_parent"
android:layout_height="wrap_content"/>

</LinearLayout>
EOF

echo "3 - Criando nova MainActivity..."

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

startActivity(Intent(this, LeitorActivity::class.java))

}

}
}
EOF

echo "4 - Atualizando Manifest..."

cat > $APP/AndroidManifest.xml << 'EOF'
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
package="com.leitoruniversalia">

<application
android:allowBackup="true"
android:label="Leitor Universal IA"
android:theme="@style/Theme.AppCompat.Light.DarkActionBar">

<activity android:name=".LeitorActivity"/>

<activity android:name=".MainActivity">

<intent-filter>

<action android:name="android.intent.action.MAIN"/>

<category android:name="android.intent.category.LAUNCHER"/>

</intent-filter>

</activity>

</application>

</manifest>
EOF

echo "=================================="
echo "INTERFACE RESETADA"
echo "=================================="
