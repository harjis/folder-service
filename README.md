# How to run locally:

```shell script
kubectl create secret generic pgpassword --from-literal POSTGRES_PASSWORD=my_pgpassword
minikube addons enable ingress
./db-helpers/pvc-apply.sh
skaffold dev
./db-helpers/create-db.sh
./db-helpers/migrate.sh
./db-helpers/seed.sh
```

# How to use as Helm Chart

1. Add helm repo
```shell script
helm repo add folder-service https://harjis.github.io/folder-service/
```

4. Install service with
````shell script
helm install folder-service harjis-charts/folder-service
````
