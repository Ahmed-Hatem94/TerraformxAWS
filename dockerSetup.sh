#!/bin/bash

# Build the docker container
docker build -t readyenv .

# Run the container with AWS credentials from .env
read -p "do you want to run the docker container now? (y/n): " containerrun
if [[ $containerrun == "Y" || $containerrun == "y" ]]; then
    docker run -it --env-file .env readyenv /bin/bash
else
    echo "To run the container with credentials: docker run -it --env-file .env readyenv /bin/bash"
    exit 0
fi


