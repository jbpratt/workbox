FROM registry.fedoraproject.org/fedora-toolbox:38


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
    htop \
    gh \
  && dnf clean all \
  && :

RUN : \
  && dnf copr enable -y atim/starship \
  && dnf install -y starship \
  && :

RUN : \
  && curl -LO https://github.com/1player/host-spawn/releases/download/1.4.2/host-spawn-x86_64 \
  && install -Dm755 host-spawn-x86_64 /usr/bin/host-spawn \
  && host-spawn --version \
  && :

RUN : \
  && curl -LO https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-client-linux.tar.gz \
  && tar xzvf openshift-client-linux.tar.gz -C /usr/local/bin/ \
  && rm -rf openshift-client-linux.tar.gz \
  && oc version \
  && :

RUN : \
  && curl -LO https://github.com/openshift-online/ocm-cli/releases/download/v0.1.67/ocm-linux-amd64 \
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
  && curl -LO https://github.com/gruntwork-io/cloud-nuke/releases/download/v0.31.1/cloud-nuke_linux_amd64 \
  && install -Dm755 cloud-nuke_linux_amd64 /usr/bin/cloud-nuke \
  && rm cloud-nuke_linux_amd64 \
  && cloud-nuke --version \
  && :

RUN : \
  && curl -LO https://github.com/openshift/rosa/releases/download/v1.2.22/rosa-linux-amd64 \
  && install -Dm755 rosa-linux-amd64 /usr/bin/rosa \
  && rm rosa-linux-amd64 \
  && rosa version \
  && :

ENV VAULT_VERSION="1.12.0"
RUN : \
  && curl -LO https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip \
  && unzip vault_${VAULT_VERSION}_linux_amd64.zip \
  && install -Dm755 vault /usr/bin/vault \
  && rm -rf vault vault_${VAULT_VERSION}_linux_amd64.zip \
  && vault --version \
  && :

RUN : \
  && git clone https://github.com/holygeek/git-number.git \
  && pushd git-number \
  && make install \
  && popd \
  && rm -rf git-number/ \
  && :

RUN : \
  && mkdir /usr/libexec/toolbox \
  && ln -s /usr/bin/host-spawn /usr/libexec/flatpak \
  && ln -s /usr/bin/host-spawn /usr/libexec/virsh \
  && ln -s /usr/bin/host-spawn /usr/libexec/podman \
  && ln -s /usr/bin/host-spawn /usr/libexec/skopeo \
  && ln -s /usr/bin/host-spawn /usr/libexec/virt-install \
  && ln -s /usr/bin/host-spawn /usr/libexec/rpm-ostree \
  && ln -s /usr/bin/host-spawn /usr/libexec/ostree \
  && ln -s /usr/bin/host-spawn /usr/libexec/nmcli \
  && ln -s /usr/bin/host-spawn /usr/libexec/openvpn \
  && :

ENV PATH="/usr/libexec/toolbox:/usr/libexec:$PATH"
