kubectl exec -it deployment/postgres-deployment -- createdb -U postgres 'folder-service_development'

kubectl rollout restart deployment/backend-deployment
