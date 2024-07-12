#!/bin/bash

haxe haxe-front.hxml                                            && \

cd ./example/                                                   && \
haxelib run priori build                                        && \
cd ../                                                          && \

haxe test-unit.hxml                                             && \
sleep 1s

if [ $? -ne 0 ]; then
    echo ""
    echo "BUILD ERROR"
    echo ""
    exit 1  # Encerra o script com código de saída 1
fi

java -jar ./build/test/unit/UnitTests.jar           && \
exit 0;