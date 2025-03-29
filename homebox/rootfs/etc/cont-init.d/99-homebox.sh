#!/usr/bin/with-contenv bashio
# ==============================================================================
# HomeBox setup
# ==============================================================================

bashio::log.info "Configuring HomeBox..."

# Create data directory if it doesn't exist
mkdir -p /data/config
chmod 777 /data/config

# Set up SSL if enabled
SSL=$(bashio::config 'ssl')
CERTFILE=$(bashio::config 'certfile')
KEYFILE=$(bashio::config 'keyfile')

if [ "$SSL" = "true" ]; then
    bashio::log.info "SSL is enabled, setting up certificates"
    
    # Check if certificates exist
    if [ ! -f "/ssl/$CERTFILE" ] || [ ! -f "/ssl/$KEYFILE" ]; then
        bashio::log.error "Certificates not found. Cannot enable SSL."
        exit 1
    fi
    
    # Create symbolic links
    ln -sf "/ssl/$CERTFILE" "/data/cert.pem"
    ln -sf "/ssl/$KEYFILE" "/data/key.pem"
fi

# Start nginx for Ingress
bashio::log.info "Starting Nginx for Ingress support"
mkdir -p /tmp/nginx/
nginx -c /etc/nginx/nginx.conf

# All done
bashio::log.info "HomeBox initialization complete" 