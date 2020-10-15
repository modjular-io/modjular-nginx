FROM nginx:1.19.3

LABEL maintainer="Jeffrey Phillips Freeman the@jeffreyfreeman.me"

# Install needed tools
RUN apt-get update && \
    apt-get upgrade -y --no-install-recommends && \
    apt-get dist-upgrade -y --no-install-recommends && \
    apt-get install -y --no-install-recommends \
      iproute2 \
      gawk && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*

# Define the nginx user as www-data
RUN sed -i 's/^[[:space:]]*user[[:space:]]*[a-zA-Z]*/user www-data/g' /etc/nginx/nginx.conf

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY 30-add-host-ip-entry.sh /docker-entrypoint.d/30-add-host-ip-entry.sh
COPY docker-run.sh /docker-run.sh
RUN mkdir -p /docker-run.d
COPY nginx-run.sh /docker-run.d/nginx-run.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "/docker-run.sh" ]

