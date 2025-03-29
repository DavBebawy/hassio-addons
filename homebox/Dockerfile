#============================#
#  HOMEBOX DOCKERFILE       #
#============================#

#################
# 1 Build Image #
#################

ARG BUILD_FROM
ARG BUILD_VERSION
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

##################
# 2 Modify Image #
##################

# Set S6 wait time
ENV S6_CMD_WAIT_FOR_SERVICES=1 \
    S6_CMD_WAIT_FOR_SERVICES_MAXTIME=0 \
    S6_SERVICES_GRACETIME=0

##################
# 3 Install apps #
##################

# Add rootfs
COPY rootfs/ /

# Uses /bin for compatibility purposes
# hadolint ignore=DL4005
RUN if [ ! -f /bin/sh ] && [ -f /usr/bin/sh ]; then ln -s /usr/bin/sh /bin/sh; fi && \
    if [ ! -f /bin/bash ] && [ -f /usr/bin/bash ]; then ln -s /usr/bin/bash /bin/bash; fi

# Create required directories
RUN mkdir -p /etc/cont-init.d

# Create banner script
RUN echo "#!/usr/bin/with-contenv bashio" > /etc/cont-init.d/00-banner.sh && \
    echo "# ==============================================================================" >> /etc/cont-init.d/00-banner.sh && \
    echo "echo \"HomeBox Add-on for Home Assistant\"" >> /etc/cont-init.d/00-banner.sh && \
    echo "echo \"Powered by DavBebawy\"" >> /etc/cont-init.d/00-banner.sh && \
    echo "echo \"Addon repository: https://github.com/davbebawy/hassio-addons\"" >> /etc/cont-init.d/00-banner.sh && \
    echo "echo \"Original application: https://github.com/sysadminsmedia/homebox\"" >> /etc/cont-init.d/00-banner.sh && \
    chmod 755 /etc/cont-init.d/00-banner.sh

# Create custom script file
RUN echo "#!/usr/bin/with-contenv bashio" > /etc/cont-init.d/01-custom_script.sh && \
    echo "# ==============================================================================" >> /etc/cont-init.d/01-custom_script.sh && \
    echo "# Run user custom scripts if configured" >> /etc/cont-init.d/01-custom_script.sh && \
    echo "# ==============================================================================" >> /etc/cont-init.d/01-custom_script.sh && \
    chmod 755 /etc/cont-init.d/01-custom_script.sh

# Create local mount script
RUN echo "#!/usr/bin/with-contenv bashio" > /etc/cont-init.d/00-local_mounts.sh && \
    echo "# ==============================================================================" >> /etc/cont-init.d/00-local_mounts.sh && \
    echo "# Mount local disks" >> /etc/cont-init.d/00-local_mounts.sh && \
    echo "# ==============================================================================" >> /etc/cont-init.d/00-local_mounts.sh && \
    echo "if bashio::config.has_value \"localdisks\"; then" >> /etc/cont-init.d/00-local_mounts.sh && \
    echo "    LOCALDISKS=\$(bashio::config \"localdisks\")" >> /etc/cont-init.d/00-local_mounts.sh && \
    echo "    echo \"Local disks = \$LOCALDISKS\"" >> /etc/cont-init.d/00-local_mounts.sh && \
    echo "    for disk in \$LOCALDISKS; do" >> /etc/cont-init.d/00-local_mounts.sh && \
    echo "        device=\"\${disk%%=*}\"" >> /etc/cont-init.d/00-local_mounts.sh && \
    echo "        mount_point=\"\${disk##*=}\"" >> /etc/cont-init.d/00-local_mounts.sh && \
    echo "        echo \"Mount \$device to \$mount_point\"" >> /etc/cont-init.d/00-local_mounts.sh && \
    echo "        mkdir -p \"\$mount_point\"" >> /etc/cont-init.d/00-local_mounts.sh && \
    echo "        mount \"\$device\" \"\$mount_point\"" >> /etc/cont-init.d/00-local_mounts.sh && \
    echo "    done" >> /etc/cont-init.d/00-local_mounts.sh && \
    echo "fi" >> /etc/cont-init.d/00-local_mounts.sh && \
    chmod 755 /etc/cont-init.d/00-local_mounts.sh

# Create SMB mounts script
RUN echo "#!/usr/bin/with-contenv bashio" > /etc/cont-init.d/00-smb_mounts.sh && \
    echo "# ==============================================================================" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "# Mount SMB share" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "# ==============================================================================" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "if bashio::config.has_value \"networkdisks\"; then" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "    NETWORKDISKS=\$(bashio::config \"networkdisks\")" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "    echo \"Network disks = \$NETWORKDISKS\"" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "    # Install necessary tools" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "    apt-get update || apk add --no-cache cifs-utils" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "    # Setup credentials" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "    if bashio::config.has_value \"cifsusername\" && bashio::config.has_value \"cifspassword\"; then" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "        SMB_USER=\$(bashio::config \"cifsusername\")" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "        SMB_PWD=\$(bashio::config \"cifspassword\")" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "        SMB_DOMAIN=\$(bashio::config \"cifsdomain\")" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "        echo \"username=\$SMB_USER\" > /etc/cifspasswd" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "        echo \"password=\$SMB_PWD\" >> /etc/cifspasswd" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "        [ -n \"\$SMB_DOMAIN\" ] && echo \"domain=\$SMB_DOMAIN\" >> /etc/cifspasswd" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "        CIFS_OPTIONS=\"credentials=/etc/cifspasswd,iocharset=utf8,vers=3.0,noperm\"" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "    else" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "        CIFS_OPTIONS=\"guest,iocharset=utf8,vers=3.0,noperm\"" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "    fi" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "    for disk in \$NETWORKDISKS; do" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "        device=\"\${disk%%=*}\"" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "        mount_point=\"\${disk##*=}\"" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "        echo \"Mount \$device to \$mount_point\"" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "        mkdir -p \"\$mount_point\"" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "        mount -t cifs \"\$device\" \"\$mount_point\" -o \"\$CIFS_OPTIONS\"" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "    done" >> /etc/cont-init.d/00-smb_mounts.sh && \
    echo "fi" >> /etc/cont-init.d/00-smb_mounts.sh && \
    chmod 755 /etc/cont-init.d/00-smb_mounts.sh

# Install packages
# hadolint ignore=DL3018
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates \
    && apt-get install -y --no-install-recommends bind-tools nginx \
    || apk add --no-cache curl ca-certificates bind-tools nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install bashio - included in the Home Assistant base image
COPY rootfs/usr/bin/bashio /usr/bin/bashio

################
# 4 Entrypoint #
################

# Create entrypoint script
ENV S6_STAGE2_HOOK=/ha_entrypoint.sh
RUN echo "#!/command/with-contenv bash" > /ha_entrypoint.sh && \
    echo "# shellcheck shell=bash" >> /ha_entrypoint.sh && \
    echo "set -e" >> /ha_entrypoint.sh && \
    echo "" >> /ha_entrypoint.sh && \
    echo "# Init" >> /ha_entrypoint.sh && \
    echo "echo \"Running HomeBox entrypoint script\"" >> /ha_entrypoint.sh && \
    echo "" >> /ha_entrypoint.sh && \
    echo "# Execute command" >> /ha_entrypoint.sh && \
    echo "if [[ \$# -gt 0 ]]; then" >> /ha_entrypoint.sh && \
    echo "    exec \"\$@\"" >> /ha_entrypoint.sh && \
    echo "else" >> /ha_entrypoint.sh && \
    echo "    # Run s6-overlay init system" >> /ha_entrypoint.sh && \
    echo "    exec \"/init\"" >> /ha_entrypoint.sh && \
    echo "fi" >> /ha_entrypoint.sh && \
    chmod 755 /ha_entrypoint.sh

VOLUME [ "/data" ]
WORKDIR /

ENTRYPOINT [ "/usr/bin/env" ]
CMD [ "/ha_entrypoint.sh" ]

############
# 5 Labels #
############

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION
ENV BUILD_VERSION="${BUILD_VERSION}"
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="davbebawy (https://github.com/davbebawy)" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Add-ons" \
    org.opencontainers.image.authors="davbebawy (https://github.com/davbebawy)" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/davbebawy" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

#################
# 6 Healthcheck #
#################

ENV HEALTH_PORT="7745" \
    HEALTH_URL=""
HEALTHCHECK \
    --interval=5s \
    --retries=5 \
    --start-period=30s \
    --timeout=25s \
    CMD curl -A "HealthCheck: Docker/1.0" -s -f "http://127.0.0.1:${HEALTH_PORT}${HEALTH_URL}" &>/dev/null || curl -k --fail "https://127.0.0.1:${HEALTH_PORT}${HEALTH_URL}" &>/dev/null || exit 1 