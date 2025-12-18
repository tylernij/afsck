#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$(realpath "$BASH_SOURCE")")"
RIVE_ANDROID_REPO="$SCRIPT_DIR/rive-android"
RIVE_AAR_DIR="$SCRIPT_DIR/post/libs"

# Clone and build rive-android, copy AAR to libs folder
setup_rive_android() {
    echo "Cloning rive-android with submodules..."
    rm -rf "$RIVE_ANDROID_REPO"
    git clone --recursive --depth 1 --shallow-submodules \
        https://github.com/rive-app/rive-android.git "$RIVE_ANDROID_REPO"
    
    echo "Building rive-android AAR..."
    cd "$RIVE_ANDROID_REPO/kotlin" || exit 1
    
    # Find gradlew - check kotlin/, then repo root
    if [ -f "./gradlew" ]; then
        chmod +x ./gradlew
        ./gradlew assembleRelease -x test
    elif [ -f "../gradlew" ]; then
        chmod +x ../gradlew
        ../gradlew :kotlin:assembleRelease -x test
    else
        echo "No gradlew found, using gradle directly..."
        gradle assembleRelease -x test
    fi
    
    # Copy the AAR to libs folder
    echo "Copying AAR to libs folder..."
    mkdir -p "$RIVE_AAR_DIR"
    cp build/outputs/aar/kotlin-release.aar "$RIVE_AAR_DIR/rive-android.aar"
    
    cd "$SCRIPT_DIR"
}

# Cleanup rive-android repo
cleanup_rive_android() {
    echo "Cleaning up rive-android..."
    rm -rf "$RIVE_ANDROID_REPO"
}

build() {
    cd "$SCRIPT_DIR/$1" || exit 1
    
    # Only setup rive-android for the "post" build
    if [ "$1" = "post" ]; then
        setup_rive_android
    fi
    
    build_android
    cd "$SCRIPT_DIR"
    
    # Cleanup after post build
    if [ "$1" = "post" ]; then
        cleanup_rive_android
        rm -rf "$RIVE_AAR_DIR"
    fi
}

getsize() {
    local pre_app="$SCRIPT_DIR/pre/app/build/outputs/apk/release/app-release-unsigned.apk"
    local post_app="$SCRIPT_DIR/post/app/build/outputs/apk/release/app-release-unsigned.apk"

    compare_size "$pre_app" "$post_app"
}
