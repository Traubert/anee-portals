FROM debian:latest as builder
# This is just to set up all the resources, won't be hosting the site

USER root
RUN apt-get update && apt-get install -y curl git tar m4
WORKDIR /tmp
COPY * ./

# fetch-and-install.sh fetches the portal data and links it to the base site.
RUN \
    git clone https://github.com/Traubert/anee-lexical-portal; \
    mkdir -p /usr/share/nginx/html/resources; \
    mkdir -p /usr/share/nginx/html/portals; \
    mv anee-lexical-portal/gexf-js-base /usr/share/nginx/html/resources/gexf-js-base; \
    bash fetch-and-install.sh; \
    m4 index.html.m4 > /usr/share/nginx/html/index.html;

FROM registry.access.redhat.com/ubi9/nginx-120

USER root

WORKDIR /usr/share/nginx/html

COPY --from=builder /usr/share/nginx/html .
COPY --from=builder /tmp/nginx.conf /etc/nginx/nginx.conf
RUN chown -R 1001:0 /usr/share/nginx/html; chmod -R a+r /usr/share/nginx/html; chmod a+r /etc/nginx/nginx.conf;

EXPOSE 8080

USER 1001
    
CMD ["nginx", "-g", "daemon off;"]
