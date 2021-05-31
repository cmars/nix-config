#!/usr/bin/env bash
set -eux
cd $(dirname $0)

machinedir=${1:-$(hostname)}
git subtree pull -P machines/$machinedir /etc/nixos master
