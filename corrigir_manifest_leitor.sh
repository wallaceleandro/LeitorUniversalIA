#!/bin/bash

echo "======================================"
echo "CORRIGINDO MANIFEST"
echo "LeitorUniversalIA"
echo "======================================"

PROJECT=~/LeitorUniversalIA

cd $PROJECT

echo "--------------------------------------"
echo "Corrigindo AndroidManifest"
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

echo "Manifest corrigido"

echo "--------------------------------------"
echo "Compilando novamente"
echo "--------------------------------------"

./gradlew assembleDebug

echo "======================================"
echo "PROCESSO FINALIZADO"
echo "======================================"

echo "APK gerado em:"
echo "app/build/outputs/apk/debug/app-debug.apk"
