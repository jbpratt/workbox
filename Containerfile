FROM registry.fedoraproject.org/fedora-toolbox:35

RUN : \
  && mkdir /usr/libexec/toolbox \
  && printf '#!/bin/bash \n# https://github.com/containers/toolbox/issues/145 \nexecutable=$(basename "$0") \nexec flatpak-spawn --host --watch-bus --forward-fd=1 --forward-fd=2 --directory="$(pwd)" --env=TERM=xterm-256color "$executable" "$@"' >/usr/libexec/toolbox/host-runner \
  && chmod +x /usr/libexec/toolbox/host-runner \
  && ln -s /usr/libexec/toolbox/host-runner /usr/libexec/flatpak \
  && ln -s /usr/libexec/toolbox/host-runner /usr/libexec/virsh \
  && ln -s /usr/libexec/toolbox/host-runner /usr/libexec/podman \
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
    fzf \
    gcc \
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
    python3-devel \
    ripgrep \
    shfmt \
    starship \
    vault \
  && dnf clean all \
  && :

RUN : \
  && curl -LO https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/linux/oc.tar.gz \
  && tar xzvf oc.tar.gz -C /usr/local/bin/ \
  && rm -rf /tmp/oc.tar.gz \
  && oc version \
  && :

RUN : \
  && curl -LO https://github.com/openshift-online/ocm-cli/releases/download/v0.1.61/ocm-linux-amd64 \
  && install -Dm755 ocm-linux-amd64 /usr/bin/ocm \
  && ocm version \
  && :

RUN : \
  && curl -LO https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
  && unzip awscli-exe-linux-x86_64.zip \
  && ./aws/install \
  && aws --version \
  && :

RUN : \
  && curl -LO https://github.com/gruntwork-io/cloud-nuke/releases/download/v0.10.0/cloud-nuke_linux_amd64 \
  && install -Dm755 cloud-nuke_linux_amd64 /usr/bin/cloud-nuke \
  && cloud-nuke --version \
  && :

RUN : \
  && curl -LO https://github.com/openshift/rosa/releases/download/v1.1.9/rosa-linux-amd64 \
  && install -Dm755 rosa-linux-amd64 /usr/bin/rosa \
  && rosa version \
  && :

ENV PATH="/usr/libexec/toolbox:/usr/libexec:$PATH"
