#!/usr/bin/env bash

ROOT_DIR="$(dirname "$(realpath "$BASH_SOURCE")")"
SCRIPTS_DIR="$ROOT_DIR/scripts"

source "$SCRIPTS_DIR/build_android.sh"
source "$SCRIPTS_DIR/build_ios.sh"

runtimes=(android ios web web-lite react react-native)

build_runtime() {
    local runtime_dir="$ROOT_DIR/runtimes/$runtime"
    source "$runtime_dir/build.sh"
    build pre &> /dev/null
    build post &> /dev/null
    getsize

    echo "$runtime: Pre=$PRE_SIZE, Post=$POST_SIZE, Diff=$SIZE_DIFF"

    unset -f build getsize
    unset PRE_SIZE POST_SIZE SIZE_DIFF
    unset SCRIPT_DIR
}

for runtime in "${runtimes[@]}"; do
    echo "======== Building $runtime ========"
    build_runtime $runtime
done