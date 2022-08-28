#!/bin/sh

pushd ~/.dots > /dev/null
home-manager switch -f ./usr/mastarija/home.nix
popd > /dev/null

