#!/bin/bash

if [ -z "$VERSION" ]
then
      echo "\$VERSION is empty"
      exit 1
fi

if [ -z "$SHA" ]
then
      echo "\$SHA is empty. Run SHA=\$(git rev-parse HEAD)"
      exit 1
fi

docker build -t d0rka/folder-service-backend:latest -t d0rka/folder-service-backend:$SHA -t d0rka/folder-service-backend:$VERSION -f ./backend/Dockerfile ./backend
docker build -t d0rka/folder-service-frontend:latest -t d0rka/folder-service-frontend:$SHA -t d0rka/folder-service-frontend:$VERSION -f ./frontend/Dockerfile ./frontend

docker push d0rka/folder-service-backend:latest
docker push d0rka/folder-service-frontend:latest

docker push d0rka/folder-service-backend:$SHA
docker push d0rka/folder-service-frontend:$SHA

docker push d0rka/folder-service-backend:$VERSION
docker push d0rka/folder-service-frontend:$VERSION
