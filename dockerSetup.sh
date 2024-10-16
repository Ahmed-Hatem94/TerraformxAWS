#!/bin/bash

cat .env | xargs printf -- '--build-arg %s\n' | xargs docker build -t readyenv .

read -p "do you want to run the docker container now? (y/n): " containerrun
if [[ $containerrun == "Y" || $containerrun == "y" ]]; then
    docker run -it readyenv /bin/bash
else
    return 0
fi


