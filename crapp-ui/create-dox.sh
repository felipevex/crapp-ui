#!/bin/bash

yes | haxelib git dox https://github.com/HaxeFoundation/dox.git

rm -rf ./build/docs

cd ./docs
rm -rf ./*
cd ..

haxe haxe-dox.hxml

haxelib run dox                                         \
    --title "Crapp UI Docs"                             \
    -i ./build/docs -o ./docs                           \
    -in ^crapp                                          \
    -in ^priori                                         \
    -in ^tricks
