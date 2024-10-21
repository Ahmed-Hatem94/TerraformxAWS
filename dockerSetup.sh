#!/bin/bash

#start building docker container with passing aws credentials as build-arg
cat .env | xargs printf -- '--build-arg %s\n' | xargs docker build -t readyenv .

#user to input if the container will be used righ now or not
read -p "do you want to run the docker container now? (y/n): " containerrun
if [[ $containerrun == "Y" || $containerrun == "y" ]]; then
    docker run -it readyenv /bin/bash
else
    echo "if you want to run the container you can run it using this command (docker run -it readyenv /bin/bash)"
    return 0
fi


