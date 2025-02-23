#!/bin/bash

yes | haxelib git dox https://github.com/HaxeFoundation/dox.git

rm -rf ./build/docs
rm -rf ./docs

haxe haxe-dox.hxml

haxelib run dox                                         \
    --title "Crapp UI Docs"                             \
    -i ./build/docs -o ./docs                           \
    -ex ^front -ex ^helper.display -ex ^datetime        
