#Get haproxy image
FROM haproxy:alpine

#copy the config into the container
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

RUN mkdir -p /run/haproxy

CMD ["haproxy -d -f /usr/local/etc/haproxy/haproxy.cfg"]

#port opening
EXPOSE 80
EXPOSE 443
