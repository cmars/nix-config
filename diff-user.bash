#!/usr/bin/env bash
set -eu
cd $(dirname $0)
diff -bcr users/$USER $HOME/.config/nixpkgs
