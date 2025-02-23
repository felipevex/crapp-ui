#!/bin/bash

haxe test-unit.hxml                                             && \
neko ./build/test/unit/UnitTests.n                              && \

haxe haxe-front.hxml                                            && \
cd ./example/                                                   && \
haxelib run priori build                                        && \
cd ../                                                          && \

sleep 1s

if [ $? -ne 0 ]; then
    echo ""
    echo "BUILD ERROR"
    echo ""
    exit 1  # Encerra o script com código de saída 1
fi


exit 0;