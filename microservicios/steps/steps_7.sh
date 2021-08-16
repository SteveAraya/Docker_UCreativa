#1 Login en azure.
az login

{
    "cloudName": "AzureCloud",
    "homeTenantId": "",
    "id": "",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Azure for Students",
    "state": "Enabled",
    "tenantId": "",
    "user": {
      "name": "",
      "type": "user"
    }
}

#2 Creamos un Service Principal.
az ad sp create-for-rbac --name ucreativa_microservicios

{
  "appId": "",
  "displayName": "ucreativa_microservicios",
  "name": "",
  "password": "",
  "tenant": ""
}

#3 Realizamos un logout de la cuenta de azure.
az logout

#4 Nos conectamos con el service principal.
az login --service-principal \
         --username "appId"  \
         --password "password"  \
         --tenant "tenant"

#5 Revisamos la lista disponible de locaciones.
az account list-locations --query '[].name'

#6 Creamos un Resource Group.
az group create -l centralus -n dev-step7-rg

#7 Creamos en Azure un Container Registry.
az acr create --resource-group dev-step7-rg --name ucreativaregistryclase10 --sku Basic

#8 Creamos la imagen de la cual vamos a hacer el deployment.
docker build --tag ucreativaregistryclase10.azurecr.io/holatest:1.0.0 .

#9 Realizamos el login al Container Registry.
az acr login --name ucreativaregistryclase10

#10 Realizamos el push de la imagen al registry que creamos.
docker push ucreativaregistryclase10.azurecr.io/holatest:1.0.0

#11 Creamos el cluster, le asignamos el label processing=aqui.
az aks create -g dev-step7-rg \
              -n Clase10Cluster \
              --node-count 1 \
              --nodepool-labels "processing=aqui" \
              --service-principal "" \
              --client-secret "" \

#12 Realizamos loging con Kubectl.
az aks get-credentials -g dev-step7-rg -n Clase10Cluster

#13 Verificamos que el login se realizo correctamente. 
kubectl get no -o wide

#14 Instalamos el hola-deployment.yml.
kubectl apply -f k8s/hola-deployment.yml

#15 Monitoreamos el estado del cluster desde la terminal.
while true; do kubectl get po -o wide; sleep 1; done

#16 Agregamos otro Nodepool.
az aks nodepool add --resource-group dev-step7-rg \
                    --cluster-name Clase10Cluster \
                    --name otro \
                    --node-count 1

#17 Corfirmamos que ambos nodos fueron creados, debemos recordar que uno tiene un label y el otro no.
kubectl get no -o wide

#18 Cambiamos la cantidad de replicas en hola-deployment.yml.
kubectl apply -f k8s/hola-deployment.yml
kubectl get po -o wide

#19 Creamos otro deployment con bastantes replicas, estas van al nodo que les plasca. 
kubectl apply -f k8s/otro-deployment.yml
kubectl get po -o wide

#21 Eliminamos todo lo que creamos en el ejercicio. 
az group delete -n dev-step7-rg