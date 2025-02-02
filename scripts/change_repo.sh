#!/bin/bash

# Set strict error handling
set -euo pipefail

# Define log function
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Main function to change repository
change_repo() {
    log "Starting repository modification"

    # Backup original repo files
    log "Creating backup of repository files"
    mkdir -p /etc/yum.repos.d/backup
    cp /etc/yum.repos.d/CentOS-*.repo /etc/yum.repos.d/backup/

    # Modify repository files
    log "Updating repository URLs"
    if ! sed -i 's/mirror.centos.org/vault.centos.org/g' /etc/yum.repos.d/CentOS-*.repo; then
        log "Error: Failed to update mirror URL"
        return 1
    fi

    if ! sed -i 's/^#.*baseurl=http/baseurl=http/g' /etc/yum.repos.d/CentOS-*.repo; then
        log "Error: Failed to uncomment baseurl"
        return 1
    fi

    if ! sed -i 's/^mirrorlist=http/#mirrorlist=http/g' /etc/yum.repos.d/CentOS-*.repo; then
        log "Error: Failed to comment mirrorlist"
        return 1
    fi

    # Clean and update yum
    log "Cleaning yum cache"
    yum clean all || { log "Error: Failed to clean yum cache"; return 1; }
    
    log "Removing yum cache directory"
    rm -rf /var/cache/yum/* || { log "Error: Failed to remove yum cache"; return 1; }
    
    log "Updating system packages"
    yum update -y || { log "Error: Failed to update packages"; return 1; }
    
    log "Upgrading system packages"
    yum upgrade -y || { log "Error: Failed to upgrade packages"; return 1; }

    log "Repository modification completed successfully"
    return 0
}

# Execute main function
if change_repo; then
    exit 0
else
    log "Script failed"
    exit 1
fi