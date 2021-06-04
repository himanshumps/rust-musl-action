FROM registry.access.redhat.com/ubi7/ubi:latest

RUN yum-config-manager --enable rhel-7-server-rpms rhel-7-server-optional-rpms rhel-server-rhscl-7-rpms rhel-7-server-devtools-rpms && \
    INSTALL_PKGS="rust-toolset-1.47" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y

COPY ./root /

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
