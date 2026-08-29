FROM registry.fedoraproject.org/fedora-toolbox:46

RUN : \
  && dnf update -y \
  && dnf install -y \
    ShellCheck \
    alsa-lib \
    automake \
    bat \
    clang \
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
    ipa-admintools \
    ipa-client \
    jq \
    kernel-devel \
    krb5-devel \
    krb5-workstation \
    libpq-devel \
    libvirt-devel \
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
    python3-libselinux \
    ripgrep \
    skopeo \
    sqlite3 \
    tmux \
    uv \
    vagrant \
    vagrant-libvirt \
    xorg-x11-server-Xvfb \
    --exclude=mercurial,subversion \
  && dnf clean all \
  && :

RUN : \
  && dnf copr enable -y atim/starship \
  && dnf install -y starship \
  && :

RUN : \
  && dnf config-manager addrepo --from-repofile=https://packages.cloud.google.com/yum/repos/cloud-sdk-el9-x86_64 \
  && dnf install -y google-cloud-cli \
  && dnf clean all \
  && gcloud version \
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
  && curl -LO https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
  && unzip awscli-exe-linux-x86_64.zip \
  && ./aws/install \
  && rm -rf aws/ awscli-exe-linux-x86_64.zip \
  && aws --version \
  && :

RUN : \
  && curl -LO https://mirror.openshift.com/pub/openshift-v4/clients/rosa/latest/rosa-linux \
  && install -Dm755 rosa-linux /usr/local/bin/rosa \
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
  && curl -fsSL https://claude.ai/install.sh | bash \
  && ~/.local/bin/claude --version \
  && :

RUN : \
  && curl -O -L "https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64" \
  && mv cosign-linux-amd64 /usr/local/bin/cosign \
  && chmod +x /usr/local/bin/cosign \
  && :

RUN : \
  && curl -sSfL https://get.anchore.io/syft | sh -s -- -b /usr/local/bin \
  && :

RUN : \
  && curl -O -L https://acli.atlassian.com/linux/latest/acli_linux_amd64/acli \
  && mv acli /usr/local/bin/acli \
  && chmod +x /usr/local/bin/acli \
  && :

COPY host-runner /usr/local/bin/host-runner

RUN : \
  && ln -s host-runner /usr/local/bin/flatpak \
  && ln -s host-runner /usr/local/bin/firefox \
  && ln -s host-runner /usr/local/bin/xdg-open \
  && ln -s host-runner /usr/local/bin/podman \
  && ln -s host-runner /usr/local/bin/buildah \
  && ln -s host-runner /usr/local/bin/rpm-ostree \
  && ln -s host-runner /usr/local/bin/sshuttle \
  && ln -s host-runner /usr/local/bin/systemctl \
  && ln -s host-runner /usr/local/bin/kind \
  && ln -s host-runner /usr/local/bin/kinit \
  && ln -s host-runner /usr/local/bin/klist \
  && ln -s host-runner /usr/local/bin/openshell \
  && :
