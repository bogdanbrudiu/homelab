#!/bin/bash
set -eu
RANCHER_VERSION=${RANCHER_VERSION:-v2.2.2}
ACME_DOMAIN=${ACME_DOMAIN:-example.com}

sudo docker run -d --restart=unless-stopped -p 8080:80 -p 8443:443 rancher/rancher:${RANCHER_VERSION} --acme-domain ${ACME_DOMAIN}