FROM registry.fedoraproject.org/fedora-toolbox:40

RUN : \
  && dnf update -y \
  && dnf install -y \
    ShellCheck \
    automake \
    bat \
    cmake \
    dnf-plugins-core \
    fd-find \
    fzf \
    gcc \
    gcc-c++ \
    gh \
    git \
    gojq \
    golang \
    htop \
    jq \
    kernel-devel \
    lsd \
    make \
    neovim \
    openssl \
    parallel \
    python3-devel \
    ripgrep \
    shfmt \
  && dnf clean all \
  && :

RUN : \
  && dnf copr enable -y atim/starship \
  && dnf install -y starship \
  && :

RUN : \
  && curl -LO https://github.com/1player/host-spawn/releases/download/v1.6.0/host-spawn-x86_64 \
  && install -Dm755 host-spawn-x86_64 /usr/local/bin/host-spawn \
  && host-spawn --version \
  && :

RUN : \
  && curl -LO https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-client-linux.tar.gz \
  && tar xzvf openshift-client-linux.tar.gz -C /usr/local/bin/ \
  && rm -rf openshift-client-linux.tar.gz \
  && oc version \
  && :

RUN : \
  && curl -LO https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/opm-linux.tar.gz \
  && tar xzvf opm-linux.tar.gz -C /usr/local/bin/ \
  && rm -rf opm-linux.tar.gz \
  && opm version \
  && :

RUN : \
  && curl -LO https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/pipelines/latest/tkn-linux-amd64.tar.gz \
  && tar xzvf tkn-linux-amd64.tar.gz -C /usr/local/bin/ --no-same-owner opc tkn \
  && rm -rf tkn-linux-amd64.tar.gz \
  && opc version \
  && :

RUN : \
  && curl -LO https://github.com/openshift-online/ocm-cli/releases/download/v0.1.74/ocm-linux-amd64 \
  && install -Dm755 ocm-linux-amd64 /usr/local/bin/ocm \
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
  && curl -LO https://github.com/openshift/rosa/releases/download/v1.2.41/rosa_Linux_x86_64.tar.gz \
  && tar xzvf rosa_Linux_x86_64.tar.gz -C /usr/local/bin/ rosa \
  && rm rosa_Linux_x86_64.tar.gz \
  && rosa version \
  && :

RUN : \
  && git clone https://github.com/holygeek/git-number.git \
  && pushd git-number \
  && make install \
  && popd \
  && rm -rf git-number/ \
  && :

RUN : \
  && curl -LO https://github.com/openshift/osdctl/releases/download/v0.29.0/osdctl_0.29.0_Linux_x86_64.tar.gz \
  && tar xzvf osdctl_0.29.0_Linux_x86_64.tar.gz -C /usr/local/bin/ osdctl \
  && rm -rf osdctl_0.29.0_Linux_x86_64.tar.gz \
  && osdctl version \
  && :

RUN : \
  && mkdir /usr/libexec/toolbox \
  && ln -s /usr/local/bin/host-spawn /usr/libexec/flatpak \
  && ln -s /usr/local/bin/host-spawn /usr/libexec/virsh \
  && ln -s /usr/local/bin/host-spawn /usr/libexec/podman \
  && ln -s /usr/local/bin/host-spawn /usr/libexec/skopeo \
  && ln -s /usr/local/bin/host-spawn /usr/libexec/virt-install \
  && ln -s /usr/local/bin/host-spawn /usr/libexec/rpm-ostree \
  && ln -s /usr/local/bin/host-spawn /usr/libexec/ostree \
  && ln -s /usr/local/bin/host-spawn /usr/libexec/nmcli \
  && ln -s /usr/local/bin/host-spawn /usr/libexec/openvpn \
  && ln -s /usr/local/bin/host-spawn /usr/libexec/kind \
  && ln -s /usr/local/bin/host-spawn /usr/libexec/sshuttle \
  && :

ENV PATH="/usr/libexec/toolbox:/usr/libexec:$PATH"
