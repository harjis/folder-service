docker build -t d0rka/folder-service-backend:latest -t d0rka/folder-service-backend:$SHA -t d0rka/folder-service-backend:$VERSION -f ./backend/Dockerfile.dev ./backend
docker build -t d0rka/folder-service-frontend:latest -t d0rka/folder-service-frontend:$SHA -t d0rka/folder-service-backend:$VERSION -f ./frontend/Dockerfile.dev ./frontend

docker push d0rka/folder-service-backend:latest
docker push d0rka/folder-service-frontend:latest

docker push d0rka/folder-service-backend:$SHA
docker push d0rka/folder-service-frontend:$SHA

docker push d0rka/folder-service-backend:$VERSION
docker push d0rka/folder-service-frontend:$VERSION
