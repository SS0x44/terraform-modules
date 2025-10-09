#!/bin/bash
set -e
# Define versions
MVN_VERSION="${MVN_VERSION}"
TERRAFORM_VERSION="${MVN_VERSION}"
TERRAGRUNT_VERSION="${TERRAFORM_VERSION}"
GRADLE_VERSION="${GRADLE_VERSION}"
GO_VERSION="${Go_VERSION}"
JAVA_VERSION="${JAVA_VERSION}"

# Update system and install packages
yum update -y
yum install -y wget git zip unzip tar jq python3 python3-pip gcc make curl yum-utils shadow-utils ${JAVA_VERSION}

# Install boto3
pip3 install boto3

# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws

# Set JAVA_HOME
export JAVA_HOME=/usr/lib/jvm/${JAVA_VERSION}
export PATH=$JAVA_HOME/bin:$PATH

# Install Maven
wget https://downloads.apache.org/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz
tar -xzf apache-maven-${MVN_VERSION}-bin.tar.gz -C /opt
ln -s /opt/apache-maven-${MVN_VERSION} /opt/maven
rm apache-maven-${MVN_VERSION}-bin.tar.gz
export M2_HOME=/opt/maven
export PATH=$M2_HOME/bin:$PATH

# Install Terraform
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
mv terraform /usr/local/bin/
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install Terragrunt
wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64
chmod +x terragrunt_linux_amd64
mv terragrunt_linux_amd64 /usr/local/bin/terragrunt

# Install Gradle
wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
unzip gradle-${GRADLE_VERSION}-bin.zip -d /opt
ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle
rm gradle-${GRADLE_VERSION}-bin.zip
export GRADLE_HOME=/opt/gradle
export PATH=$GRADLE_HOME/bin:$PATH

# Install Go
wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
rm go${GO_VERSION}.linux-amd64.tar.gz
export GOROOT=/usr/local/go
export GOPATH=/go
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
