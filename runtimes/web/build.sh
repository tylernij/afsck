#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(realpath "$BASH_SOURCE")")"

build() {
    return 0
}

getsize() {
    local pre_app="$SCRIPT_DIR/pre"
    local post_app="$SCRIPT_DIR/post"

    PRE_SIZE=$(du -sk "$pre_app" | cut -f1)
    POST_SIZE=$(du -sk "$post_app" | cut -f1)
    SIZE_DIFF=$((POST_SIZE - PRE_SIZE))
}