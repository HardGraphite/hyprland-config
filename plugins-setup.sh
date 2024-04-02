#!/bin/bash

HYPR_CONF_DIR=$(realpath $(dirname "$0"))
TEMP_REPO_DIR=$(mktemp -d /tmp/hypr.XXXXX)

function cleanup_and_exit {
    rm -rf "$TEMP_REPO_DIR"
    exit $1
}

[[ -d  "$HYPR_CONF_DIR/plugins" ]] || mkdir "$HYPR_CONF_DIR/plugins"
echo 'HYPR_CONF_DIR =' $HYPR_CONF_DIR
echo 'TEMP_REPO_DIR =' $TEMP_REPO_DIR

cd "$TEMP_REPO_DIR" || exit 1
git clone 'https://github.com/HardGraphite/hyprland-hypaper.git' --depth=1 || cleanup_and_exit 1
cd 'hyprland-hypaper'
make -j$(nproc) || cleanup_and_exit 1
strip build/hypaper.so
cp build/hypaper.so "$HYPR_CONF_DIR/plugins/"

cleanup_and_exit 0
