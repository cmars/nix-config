#!/usr/bin/env bash
set -eux
cd $(dirname $0)

userdir=${1:-${USER}}
git subtree pull -P users/$userdir $HOME/.config/nixpkgs master
