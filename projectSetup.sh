#! /bin/bash

#Function to prepare docker container
dockerprep() {
    read -p "are you going to use the docker container to run the project? (y/n): " docker_use
    if [[ $docker_use == "Y" || $docker_use == "y" ]]; then
        chmod +x dockerSetup.sh
        . dockerSetup.sh
        return
    else 
        echo "enjoy your project :D !"
        return
    fi
    return
}

#function to prepare aws credentials
awsprepare(){
    echo "we'll prepare the project for you"
    echo "Could you enter the AWS Credentials as following:"
    #asking for aws credentials
    read -p  'AWS_ACCESS_KEY_ID: ' aws_access_key_id
    read -sp  'AWS_SECRET_ACCESS_KEY: ' aws_secret_access_key
    echo
    read -p  'AWS_DEFAULT_REGION: ' aws_default_region
    #writing credentials to .env file to be used later to pass credentials to the docker container
    echo "AWS_ACCESS_KEY_ID="$aws_access_key_id > ./.env
    echo "AWS_SECRET_ACCESS_KEY="$aws_secret_access_key >> ./.env
    echo "AWS_DEFAULT_REGION="$aws_default_region >> ./.env

    #if the credentials exist ask the user for a prompt if the same credentials will be used or new credentials will be needed 
    if [ -f .env ]; then
        export $(grep -v '^#' .env | xargs)
    else
        echo ".env file not found."
        return 1
    fi
    dockerprep
    return
}

#if the credentials exist ask the user for a prompt if the same credentials will be used or new credentials will be needed 
if [ -f .env ]; then
    read -p ".env file found. Do you want to use the current .env file? (y/n): " use_env
    if [[ $use_env == "y" || $use_env == "Y" ]]; then
        export $(grep -v '^#' .env | xargs)
        dockerprep
    else 
        echo "let's create new credentials"
        awsprepare
    fi
else 
    echo 
    awsprepare
fi