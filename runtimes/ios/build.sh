#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(realpath "$BASH_SOURCE")")"

build() {
    cd "$SCRIPT_DIR/$1" || exit 1
    xcodebuild archive \
        -project demo.xcodeproj \
        -scheme demo \
        -configuration Release \
        -archivePath build/demo.xcarchive \
        CODE_SIGN_IDENTITY="" \
        CODE_SIGNING_REQUIRED=NO \
        CODE_SIGNING_ALLOWED=NO
    cd "$SCRIPT_DIR"
}

getsize() {
    local pre_app="$SCRIPT_DIR/pre/build/demo.xcarchive/Products/Applications/demo.app"
    local post_app="$SCRIPT_DIR/post/build/demo.xcarchive/Products/Applications/demo.app"

    PRE_SIZE=$(du -sk "$pre_app" | cut -f1)
    POST_SIZE=$(du -sk "$post_app" | cut -f1)
    SIZE_DIFF=$((POST_SIZE - PRE_SIZE))
}