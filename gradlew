#!/usr/bin/env sh

DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -z "$JAVA_HOME" ]; then
  java_cmd="java"
else
  java_cmd="$JAVA_HOME/bin/java"
fi

exec "$java_cmd" -jar "$DIR/gradle/wrapper/gradle-wrapper.jar" "$@"
