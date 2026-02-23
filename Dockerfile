# Using a small debian container
FROM bitnami/minideb:latest

# Define build arguments
ARG TERRAFORM_VERSION=1.9.6

# Set working directory
WORKDIR /app

# Install packages, Terraform, and AWS CLI in a single layer to minimize size
RUN install_packages python3 ansible-core unzip wget curl ca-certificates && \
    wget -O /tmp/terraform.zip "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_$(dpkg --print-architecture).zip" && \
    unzip /tmp/terraform.zip -d /usr/bin && \
    rm /tmp/terraform.zip && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" && \
    unzip /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install && \
    rm -rf /tmp/aws /tmp/awscliv2.zip

# Copy project files
COPY . .

# Initialize terraform
RUN terraform init

# Entrypoint - AWS credentials should be passed as environment variables at runtime
CMD ["/bin/bash"]