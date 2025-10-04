#!/bin/bash
set -euo pipefail

REGION="${REGION}"
ACCOUNT_ID="${ACCOUNT_ID}"
TERRAFORM_VERSION="${TERRAFORM_VERSION}"
TERRAGRUNT_VERSION="${TERRAGRUNT_VERSION}"
MAVEN_VERSION="${MAVEN_VERSION}"
JAVA_VERSION="${JAVA_VERSION}"
GITLAB_URL="${GITLAB_URL}"
ECR_REGISTRY="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com"
DOCKER_IMAGE="${ECR_REGISTRY}/gitlab-runner-image:latest"

yum update -y
yum install -y unzip wget  git jq zip python3 python3-pip docker ${JAVA_VERSION}
sleep 5

# GitLab Runner install
curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
chmod +x /usr/local/bin/gitlab-runner
useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
usermod -aG docker gitlab-runner
gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner

systemctl enable docker
systemctl start docker
systemctl enable gitlab-runner
systemctl start gitlab-runner

# Terraform
wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/terraform.zip
unzip -q /tmp/terraform.zip -d /usr/local/bin

# Terragrunt
wget -q https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 -O /usr/local/bin/terragrunt
chmod +x /usr/local/bin/terragrunt

# Java
amazon-linux-extras enable ${JAVA_VERSION}
yum install -y ${JAVA_VERSION}

# Maven
wget -q https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.zip -O /tmp/maven.zip
unzip -q /tmp/maven.zip -d /opt
ln -sfn /opt/apache-maven-${MAVEN_VERSION} /opt/maven

# Environment variables
cat <<EOF >> /etc/profile.d/dev_env.sh
export JAVA_HOME=/usr/lib/jvm/${JAVA_VERSION}
export MAVEN_HOME=/opt/maven
export PATH=\$PATH:/opt/maven/bin:/usr/local/bin
EOF
chmod +x /etc/profile.d/dev_env.sh
source /etc/profile.d/dev_env.sh

# Docker login to ECR
aws ecr get-login-password --region "$REGION" | docker login --username AWS --password-stdin "$ECR_REGISTRY"

# Register GitLab Runners
gitlab-runner register --non-interactive \
  --description "app_runner_01" \
  --url "$GITLAB_URL" \
  --token "${RUNNER_TOKEN_01}" \
  --executor "docker" \
  --docker-image "$DOCKER_IMAGE"

gitlab-runner register --non-interactive \
  --description "app_runner_02" \
  --url "$GITLAB_URL" \
  --token "${RUNNER_TOKEN_02}" \
  --executor "docker" \
  --docker-image "$DOCKER_IMAGE"

gitlab-runner register --non-interactive \
  --description "app_runner_03" \
  --url "$GITLAB_URL" \
  --token "${RUNNER_TOKEN_03}" \
  --executor "docker" \
  --docker-image "$DOCKER_IMAGE"

systemctl restart gitlab-runner