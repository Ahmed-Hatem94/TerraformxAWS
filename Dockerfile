#using a small debian container

FROM bitnami/minideb:latest

#installing packages needed for our project, terraform and aws

RUN install_packages python3 ansible-core unzip 
RUN wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/1.9.6/terraform_1.9.6_linux_386.zip  && unzip /tmp/terraform.zip -d /tmp/ && mv /tmp/terraform /usr/bin && rm -f /tmp/terraform.zip
RUN wget -O /tmp/awscliv2.zip  "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" && unzip /tmp/awscliv2.zip -d /tmp/ && /tmp/aws/install && rm -f /tmp/awscliv2.zip

#copying folder files to container
COPY . /tmp/TerraformxAWS
WORKDIR /tmp/TerraformxAWS

#initiallizing terraform
RUN terraform init

#Passing AWS credentials to the container 
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION


ENV  AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
ENV  AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
ENV  AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION


CMD ["cd", "/tmp/TerraformxAWS"]