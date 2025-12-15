#!/usr/bin/env bash

runtimes=(android ios web web-lite)

for runtime in "${runtimes[@]}"; do
    ./$runtime/build.sh
done