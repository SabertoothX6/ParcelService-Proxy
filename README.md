# ParcelService-Proxy

this is a more  than quick and dirty try to use a LoadBalancer in this case a HAProxy

## build docker image
```sh
docker build -t parcelservice-proxy .
```
## create docker container
```sh
docker run -d -p 80:80 -h proxy --network=ParcelService --name=proxy parcelservice-proxy
```
