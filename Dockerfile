FROM --platform=linux/amd64 ubuntu:22.04

ARG USER
ARG UID
ARG TF_VERSION=1.7.5
ARG GCLOUD_PATH=/usr/local

WORKDIR /workdir

RUN useradd -m -u "${UID}" "${USER}"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  bash \
  ca-certificates \
  curl \
  git \
  jq \
  wget \
  unzip \
  sudo \
  apt-transport-https \
  gnupg \
  lsb-release \
  && rm -rf /var/lib/apt/lists/*

# Install terraform
RUN curl -sL -o terraform_${TF_VERSION}_linux_amd64.zip https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip \
  && unzip terraform_${TF_VERSION}_linux_amd64.zip \
  && mv terraform /bin/terraform \
  && rm -rf terraform_${TF_VERSION}_linux_amd64.zip

# Install Task
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /bin

# Install GCloud SDK
RUN curl -sSL https://sdk.cloud.google.com | bash -s -- --disable-prompts --install-dir="${GCLOUD_PATH}"
ENV PATH $PATH:"${GCLOUD_PATH}"/google-cloud-sdk/bin

# Install Trivy
RUN curl -sSL https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null \
  && echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  trivy

# Install Infracost
RUN curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh

USER "${USER}"

HEALTHCHECK CMD terraform --version && gcloud --version
