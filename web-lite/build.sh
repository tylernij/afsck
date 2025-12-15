#!/usr/bin/env bash

getsize() {
    local script_dir="$(dirname "$0")"
    local pre_app="$script_dir/pre"
    local post_app="$script_dir/post"

    local pre_size=$(du -sk "$pre_app" | cut -f1)
    local post_size=$(du -sk "$post_app" | cut -f1)

    local diff=$((post_size - pre_size))

    echo "Pre app size:  ${pre_size}K"
    echo "Post app size: ${post_size}K"
    echo "Difference:    ${diff}K"
}

getsize