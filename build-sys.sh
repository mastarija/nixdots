#!/bin/sh

pushd ~/.dots > /dev/null
sudo nixos-rebuild switch -I nixos-config=./sys/setup.nix
popd > /dev/null

