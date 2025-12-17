#!/usr/bin/env bash

# Build an Android project.
build_android() {
    ./gradlew clean assembleRelease
}