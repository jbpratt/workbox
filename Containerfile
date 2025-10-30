FROM registry.fedoraproject.org/fedora-toolbox:42

RUN : \
  && dnf update -y \
  && dnf install -y \
    ShellCheck \
    alsa-lib \
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
    gtk3-devel \
    htop \
    jq \
    kernel-devel \
    libpq-devel \
    lsd \
    make \
    neovim \
    npm \
    nss \
    openldap-devel \
    openssl \
    parallel \
    pinentry \
    python3-devel \
    ripgrep \
    shfmt \
    skopeo \
    uv \
    xorg-x11-server-Xvfb \
    --exclude=mercurial,subversion \
  && dnf clean all \
  && :

RUN : \
  && dnf copr enable -y atim/starship \
  && dnf install -y starship \
  && :

RUN : \
  && curl -LO https://github.com/1player/host-spawn/releases/download/v1.6.2/host-spawn-x86_64 \
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
  && tar xzvf opm-linux.tar.gz -C /usr/local/bin/ opm-rhel8 --transform='s/-rhel8//g' \
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
  && curl -LO https://github.com/openshift-online/ocm-cli/releases/download/v1.0.8/ocm-linux-amd64 \
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
  && curl -LO https://github.com/openshift/rosa/releases/download/v1.2.57/rosa_Linux_x86_64.tar.gz \
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
  && npm install -g @google/gemini-cli \
  && gemini --version \
  && :

RUN : \
  && npm install -g @anthropic-ai/claude-code \
  && claude --version \
  && :

RUN : \
  && npm install -g @charmland/crush \
  && crush --version \
  && :

RUN : \
  && npm install -g typescript-language-server \
  && :

RUN : \
  && curl -O -L "https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64" \
  && mv cosign-linux-amd64 /usr/local/bin/cosign \
  && chmod +x /usr/local/bin/cosign \
  && :

RUN : \
  && curl -sSfL https://get.anchore.io/syft | sh -s -- -b /usr/local/bin \
  && :

COPY host-runner /usr/local/bin/host-runner

RUN : \
  && ln -s host-runner /usr/local/bin/flatpak \
  && ln -s host-runner /usr/local/bin/firefox \
  && ln -s host-runner /usr/local/bin/xdg-open \
  && ln -s host-runner /usr/local/bin/podman \
  && ln -s host-runner /usr/local/bin/rpm-ostree \
  && ln -s host-runner /usr/local/bin/sshuttle \
  && ln -s host-runner /usr/local/bin/systemctl \
  && :
