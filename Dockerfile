FROM registry.access.redhat.com/ubi7/ubi:latest
# yum-config-manager --enable rhel-7-server-rpms rhel-7-server-optional-rpms rhel-server-rhscl-7-rpms rhel-7-server-devtools-rpms && \
RUN yum-config-manager --enable rhel-server-rhscl-7-rpms && INSTALL_PKGS="rust-toolset-7" && \
    yum --disableplugin=subscription-manager search $INSTALL_PKGS --enablerepo=* && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y

COPY ./root /

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
