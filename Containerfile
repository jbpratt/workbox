FROM registry.fedoraproject.org/fedora-toolbox:35

RUN : \
  && mkdir /usr/libexec/toolbox \
  && printf '#!/bin/bash \n# https://github.com/containers/toolbox/issues/145 \nexecutable=$(basename "$0") \nexec flatpak-spawn --host --watch-bus --forward-fd=1 --forward-fd=2 --directory="$(pwd)" --env=TERM=xterm-256color "$executable" "$@"' >/usr/libexec/toolbox/host-runner \
  && chmod +x /usr/libexec/toolbox/host-runner \
  && ln -s /usr/libexec/toolbox/host-runner /usr/libexec/flatpak \
  && ln -s /usr/libexec/toolbox/host-runner /usr/libexec/virsh \
  && ln -s /usr/libexec/toolbox/host-runner /usr/libexec/podman \
  && ln -s /usr/libexec/toolbox/host-runner /usr/libexec/skopeo \
  && ln -s /usr/libexec/toolbox/host-runner /usr/libexec/virt-install \
  && ln -s /usr/libexec/toolbox/host-runner /usr/libexec/rpm-ostree \
  && ln -s /usr/libexec/toolbox/host-runner /usr/libexec/ostree \
  && ln -s /usr/libexec/toolbox/host-runner /usr/libexec/nmcli \
  && :

RUN : \
  && dnf update -y \
  && dnf install -y \
    ShellCheck \
    automake \
    bat \
    cmake \
    dnf-plugins-core \
    fzf \
    gcc \
    gcc-c++ \
    git \
    gojq \
    golang \
    jq \
    kernel-devel \
    lsd \
    make \
    neovim \
    openssl \
    python3-devel \
    ripgrep \
    shfmt \
    starship \
  && dnf clean all \
  && :

ENV OCM_VERSION="v0.1.62"
ENV CLOUD_NUKE_VERSION="v0.11.3"
ENV ROSA_VERSION="v1.1.11"
ENV VAULT_VERSION="1.9.4"

RUN : \
  && curl -LO https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/linux/oc.tar.gz \
  && tar xzvf oc.tar.gz -C /usr/local/bin/ \
  && rm -rf oc.tar.gz \
  && oc version \
  && :

RUN : \
  && curl -LO https://github.com/openshift-online/ocm-cli/releases/download/${OCM_VERSION}/ocm-linux-amd64 \
  && install -Dm755 ocm-linux-amd64 /usr/bin/ocm \
  && rm ocm-linux-amd64 \
  && ocm version \
  && :

RUN : \
  && curl -LO https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
  && unzip awscli-exe-linux-x86_64.zip \
  && ./aws/install \
  && rm -rf aws/ awscli-exe-linux-x86_64.zip \
  && aws --version \
  && :

RUN : \
  && curl -LO https://github.com/gruntwork-io/cloud-nuke/releases/download/${CLOUD_NUKE_VERSION}/cloud-nuke_linux_amd64 \
  && install -Dm755 cloud-nuke_linux_amd64 /usr/bin/cloud-nuke \
  && rm cloud-nuke_linux_amd64 \
  && cloud-nuke --version \
  && :

RUN : \
  && curl -LO https://github.com/openshift/rosa/releases/download/${ROSA_VERSION}/rosa-linux-amd64 \
  && install -Dm755 rosa-linux-amd64 /usr/bin/rosa \
  && rm rosa-linux-amd64 \
  && rosa version \
  && :

RUN : \
  && curl -LO https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip \
  && unzip vault_${VAULT_VERSION}_linux_amd64.zip \
  && install -Dm755 vault /usr/bin/vault \
  && rm -rf vault vault_${VAULT_VERSION}_linux_amd64.zip \
  && vault --version \
  && :

ENV PATH="/usr/libexec/toolbox:/usr/libexec:$PATH"
