#!/bin/bash
set -e

echo "======================================"
echo "REPARANDO ANDROID MANIFEST"
echo "======================================"

MANIFEST=app/src/main/AndroidManifest.xml

echo "Recriando AndroidManifest.xml correto..."

cat > $MANIFEST << 'EOF'
<?xml version="1.0" encoding="utf-8"?>

<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.leitoruniversalia">

    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>

    <application
        android:allowBackup="true"
        android:label="Leitor Universal IA"
        android:supportsRtl="true"
        android:theme="@style/Theme.AppCompat.Light.DarkActionBar">

        <activity
            android:name=".MainActivity"
            android:exported="true">

            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>

                <category android:name="android.intent.category.LAUNCHER"/>

            </intent-filter>

        </activity>

        <activity android:name=".LibraryActivity"/>

    </application>

</manifest>
EOF

echo "Manifest corrigido."

echo "Limpando projeto..."
./gradlew clean

echo "Gerando APK novamente..."
./gradlew assembleDebug --no-daemon

echo "======================================"
echo "MANIFEST REPARADO COM SUCESSO"
echo "======================================"
