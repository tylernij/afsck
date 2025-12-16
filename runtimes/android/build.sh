#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(realpath "$BASH_SOURCE")")"

build() {
    cd "$SCRIPT_DIR/$1" || exit 1
    ./gradlew clean assembleRelease
    cd "$SCRIPT_DIR"
}

getsize() {
    local pre_app="$SCRIPT_DIR/pre/app/build/outputs/apk/release/app-release-unsigned.apk"
    local post_app="$SCRIPT_DIR/post/app/build/outputs/apk/release/app-release-unsigned.apk"

    PRE_SIZE=$(du -sk "$pre_app" | cut -f1)
    POST_SIZE=$(du -sk "$post_app" | cut -f1)
    SIZE_DIFF=$((POST_SIZE - PRE_SIZE))
}