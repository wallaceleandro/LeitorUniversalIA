
#!/bin/bash

echo "======================================"
echo "INSTALAÇÃO TOTAL"
echo "LeitorUniversalIA"
echo "ETAPA 1 A 7 AUTOMÁTICA"
echo "======================================"

PROJECT=LeitorUniversalIA

echo "--------------------------------------"
echo "ETAPA 1 - LIMPEZA"
echo "--------------------------------------"

rm -rf $PROJECT
mkdir $PROJECT
cd $PROJECT

echo "--------------------------------------"
echo "ETAPA 2 - ESTRUTURA"
echo "--------------------------------------"

mkdir -p app/src/main/java/com/leitor/universal
mkdir -p app/src/main/res/layout
mkdir -p app/src/main/res/values

echo "--------------------------------------"
echo "ETAPA 3 - settings.gradle"
echo "--------------------------------------"

cat > settings.gradle <<EOF
rootProject.name = "LeitorUniversalIA"
include ':app'
EOF

echo "--------------------------------------"
echo "ETAPA 4 - build.gradle ROOT"
echo "--------------------------------------"

cat > build.gradle <<EOF
buildscript {
    ext.kotlin_version = '1.9.22'
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.2.2'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:\$kotlin_version"
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
EOF

echo "--------------------------------------"
echo "ETAPA 5 - gradle.properties"
echo "--------------------------------------"

cat > gradle.properties <<EOF
android.useAndroidX=true
android.enableJetifier=true
org.gradle.jvmargs=-Xmx2048m
EOF

echo "--------------------------------------"
echo "ETAPA 6 - build.gradle APP"
echo "--------------------------------------"

mkdir app

cat > app/build.gradle <<EOF
plugins {
    id 'com.android.application'
    id 'org.jetbrains.kotlin.android'
}

android {
    namespace 'com.leitor.universal'
    compileSdk 34

    defaultConfig {
        applicationId "com.leitor.universal"
        minSdk 21
        targetSdk 34
        versionCode 1
        versionName "1.0"
    }

    buildTypes {
        release {
            minifyEnabled false
        }
    }
}

dependencies {

    implementation 'androidx.core:core-ktx:1.12.0'
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.11.0'

}
EOF

echo "--------------------------------------"
echo "ETAPA 7 - AndroidManifest"
echo "--------------------------------------"

cat > app/src/main/AndroidManifest.xml <<EOF
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <application
        android:label="LeitorUniversalIA"
        android:theme="@style/Theme.AppCompat.Light.DarkActionBar">

        <activity
            android:name=".MainActivity"
            android:exported="true">

            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>

        </activity>

    </application>

</manifest>
EOF

echo "--------------------------------------"
echo "CRIANDO LAYOUT"
echo "--------------------------------------"

cat > app/src/main/res/layout/activity_main.xml <<EOF
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical"
    android:padding="20dp"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <EditText
        android:id="@+id/editText"
        android:hint="Digite um texto"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"/>

    <Button
        android:id="@+id/button"
        android:text="LER TEXTO"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"/>

</LinearLayout>
EOF

echo "--------------------------------------"
echo "CRIANDO STRINGS"
echo "--------------------------------------"

cat > app/src/main/res/values/strings.xml <<EOF
<resources>
    <string name="app_name">LeitorUniversalIA</string>
</resources>
EOF

echo "--------------------------------------"
echo "CRIANDO MainActivity"
echo "--------------------------------------"

cat > app/src/main/java/com/leitor/universal/MainActivity.kt <<EOF
package com.leitor.universal

import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val editText = findViewById<EditText>(R.id.editText)
        val button = findViewById<Button>(R.id.button)

        button.setOnClickListener {
            val texto = editText.text.toString()
            Toast.makeText(this, texto, Toast.LENGTH_LONG).show()
        }
    }
}
EOF

echo "--------------------------------------"
echo "CRIANDO GRADLE WRAPPER"
echo "--------------------------------------"

gradle wrapper

echo "--------------------------------------"
echo "COMPILANDO"
echo "--------------------------------------"

./gradlew assembleDebug

echo "======================================"
echo "FINALIZADO"
echo "======================================"

echo "APK:"
echo "app/build/outputs/apk/debug/app-debug.apk"
