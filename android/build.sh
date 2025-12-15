#!/usr/bin/env bash

build() {
    cd "$(dirname "$0")/$1" || exit 1
    ./gradlew clean assembleRelease
    cd ..
}

getsize() {
    local script_dir="$(dirname "$0")"
    local pre_apk="$script_dir/pre/app/build/outputs/apk/release/app-release-unsigned.apk"
    local post_apk="$script_dir/post/app/build/outputs/apk/release/app-release-unsigned.apk"

    local pre_size=$(stat -f%z "$pre_apk" 2>/dev/null || stat -c%s "$pre_apk" 2>/dev/null)
    local post_size=$(stat -f%z "$post_apk" 2>/dev/null || stat -c%s "$post_apk" 2>/dev/null)

    local diff=$((post_size - pre_size))

    echo "Pre APK size:  $pre_size bytes"
    echo "Post APK size: $post_size bytes"
    echo "Difference:    $diff bytes"
}

build pre
build post
getsize