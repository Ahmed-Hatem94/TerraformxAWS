FROM bitnami/minideb:latest

RUN install_packages python3 ansible-core unzip git

RUN wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/1.9.6/terraform_1.9.6_linux_386.zip  && unzip /tmp/terraform.zip -d /tmp/ && mv /tmp/terraform /usr/bin && rm -f /tmp/terraform.zip

RUN wget -O /tmp/awscliv2.zip  "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" && unzip /tmp/awscliv2.zip -d /tmp/ && /tmp/aws/install && rm -f /tmp/awscliv2.zip