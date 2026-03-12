#!/bin/bash
# =============================================
# Script para criar workflow GitHub Actions
# para build Android (debug e release)
# =============================================

# Nome do arquivo do workflow
WORKFLOW_DIR=".github/workflows"
WORKFLOW_FILE="$WORKFLOW_DIR/android-build.yml"

echo "Criando pasta do workflow..."
mkdir -p $WORKFLOW_DIR

echo "Criando arquivo do workflow..."
cat > $WORKFLOW_FILE << 'EOF'
name: Build Android APKs

on:
  push:
    branches:
      - main
  pull_request:

jobs:
  build:
    name: Build APKs
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Set up JDK 17
        uses: actions/setup-java@v3
        with:
          distribution: temurin
          java-version: 17

      - name: Cache Gradle
        uses: actions/cache@v3
        with:
          path: |
            ~/.gradle/caches
            ~/.gradle/wrapper
          key: ${{ runner.os }}-gradle-${{ hashFiles('**/*.gradle*', '**/gradle-wrapper.properties') }}
          restore-keys: |
            ${{ runner.os }}-gradle-

      - name: Make gradlew executable
        run: chmod +x ./gradlew

      - name: Build Debug APK
        run: ./gradlew assembleDebug --no-daemon

      - name: Build Release APK
        run: |
          ./gradlew assembleRelease --no-daemon || true

      - name: Upload Debug APK
        uses: actions/upload-artifact@v3
        with:
          name: LeitorUniversalIA-debug
          path: app/build/outputs/apk/debug/app-debug.apk

      - name: Upload Release APK
        uses: actions/upload-artifact@v3
        with:
          name: LeitorUniversalIA-release
          path: app/build/outputs/apk/release/app-release.apk
EOF

echo "Workflow criado em $WORKFLOW_FILE"

# Adiciona, comita e envia para GitHub
echo "Fazendo commit e push para GitHub..."
git add $WORKFLOW_FILE
git commit -m "Adiciona workflow completo de build Android"
git push origin main

echo "Pronto! Workflow enviado ao GitHub. Confira a aba Actions."
