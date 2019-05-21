#!/bin/bash
cd /root/pagekite
KITE_PASSWORD=${KITE_PASSWORD}
KITE_DOMAIN=${KITE_DOMAIN}

sudo docker run -d --restart=unless-stopped \
--isfrontend --ports=80,443 \
--protos=http,https \
--domain=http,https:*.$KITE_DOMAIN:$KITE_PASSWORD 