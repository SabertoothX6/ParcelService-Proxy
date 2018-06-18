#Get haproxy image
FROM haproxy

ENV HAPROXY_USER haproxy

RUN groupadd --system ${HAPROXY_USER} && \
  useradd --system --gid ${HAPROXY_USER} ${HAPROXY_USER} && \
  mkdir --parents /var/lib/${HAPROXY_USER} && \
  chown -R ${HAPROXY_USER}:${HAPROXY_USER} /var/lib/${HAPROXY_USER}

#copy the config into the container
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

RUN mkdir -p /run/haproxy

CMD ["haproxy", "-d", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]

#port opening
EXPOSE 8443
