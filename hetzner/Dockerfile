
FROM hashicorp/terraform:light 

COPY ./Dockerfile ./proxy.cer* /usr/local/share/ca-certificates/
RUN rm /usr/local/share/ca-certificates/Dockerfile
RUN update-ca-certificates


RUN apk update && apk -Uuv add  ca-certificates openssl groff less git bash wget make jq curl unzip sed openssh

WORKDIR /app

ENTRYPOINT ["/bin/terraform"]


CMD ["--help"]

ENV HCLOUD_VERSION=1.2.0
ENV HCLOUD_FILENAME=terraform-provider-hcloud_v${HCLOUD_VERSION}_linux_amd64.zip
ENV HCLOUD_TERRAFORM_URL=https://github.com/terraform-providers/terraform-provider-hcloud/releases/download/v${HCLOUD_VERSION}/${HCLOUD_FILENAME}
ENV HCLOUD_TERRAFORM_SHA256SUM=

RUN rm -rf /tmp/* && \
    rm -rf /var/cache/apk/* && \
    rm -rf /var/tmp/*

RUN terraform --version

ARG VCS_REF

LABEL org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/insekticid/docker-terraform-hcloud-example"
    
