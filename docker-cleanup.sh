#!/bin/bash

#https://gist.github.com/bastman/5b57ddb3c11942094f8d0a97d461b430


docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker network prune -f
docker system prune -f

#docker image prune
#docker image prune -a --filter "until=24h"