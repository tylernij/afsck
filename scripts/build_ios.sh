#!/usr/bin/env bash

# Build an iOS project.
build_ios() {
    local name="${1:-demo}"

    xcodebuild archive \
        -project "$name.xcodeproj" \
        -scheme "$name" \
        -configuration Release \
        -archivePath "build/$name.xcarchive" \
        CODE_SIGN_IDENTITY="" \
        CODE_SIGNING_REQUIRED=NO \
        CODE_SIGNING_ALLOWED=NO
}