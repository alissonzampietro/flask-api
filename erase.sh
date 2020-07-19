docker ps -aq | xargs docker rm -v
docker images | awk '{print $3}' | column  | awk '{print $2}' | xargs docker rmi