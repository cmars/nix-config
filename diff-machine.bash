#!/usr/bin/env bash
set -eu
cd $(dirname $0)
diff -bcr machines/$(hostname) /etc/nixos
