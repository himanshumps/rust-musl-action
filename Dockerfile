FROM registry.access.redhat.com/ubi7/ubi:latest
# yum-config-manager --enable rhel-7-server-rpms rhel-7-server-optional-rpms rhel-server-rhscl-7-rpms rhel-7-server-devtools-rpms && \
RUN INSTALL_PKGS="rust cargo" && \
    yum --disableplugin=subscription-manager search $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y

COPY ./root /

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
