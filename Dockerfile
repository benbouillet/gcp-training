FROM --platform=linux/amd64 ubuntu:22.04

ARG USER=nonroot
ARG UID=1000
ARG TF_VERSION=1.8.0
ARG CLOUDSDK_INSTALL_DIR=/usr/local/gcloud/

WORKDIR /workdir

RUN useradd -m -u "${UID}" "${USER}"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  bash \
  ca-certificates \
  curl \
  git \
  jq \
  unzip \
  sudo \
  ansible \
  && rm -rf /var/lib/apt/lists/*

# Install terraform
RUN curl -sL -o terraform_${TF_VERSION}_linux_amd64.zip https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip \
  && unzip terraform_${TF_VERSION}_linux_amd64.zip \
  && mv terraform /bin/terraform \
  && rm -rf terraform_${TF_VERSION}_linux_amd64.zip

# Install Task
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /bin

# Install GCloud SDK
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin
