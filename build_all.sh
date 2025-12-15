#!/usr/bin/env bash

runtimes=(android ios web web-lite react)

for runtime in "${runtimes[@]}"; do
    ./$runtime/build.sh
done