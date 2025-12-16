#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(realpath "$BASH_SOURCE")")"

build() {
    cd "$SCRIPT_DIR/$1" || exit 1
    rm -rf node_modules dist
    npm install
    npx expo export --platform android
    npx expo export --platform ios
    # TODO: separate size calculation for Android and iOS
    cd "$SCRIPT_DIR"
}

getsize() {
    local pre_app="$SCRIPT_DIR/pre/dist"
    local post_app="$SCRIPT_DIR/post/dist"

    PRE_SIZE=$(du -sk "$pre_app" | cut -f1)
    POST_SIZE=$(du -sk "$post_app" | cut -f1)
    SIZE_DIFF=$((POST_SIZE - PRE_SIZE))
}