#1 Instalación de azure-cli.
brew update && brew install azure-cli

#2 Instalación de kubectl.
brew install kubectl

#3 Login en azure.
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

#4 Creamos un Service Principal.
az ad sp create-for-rbac --name ucreativa_microservicios

{
  "appId": "",
  "displayName": "ucreativa_microservicios",
  "name": "",
  "password": "",
  "tenant": ""
}

#5 Realizamos un logout de la cuenta de azure.
az logout

#6 Nos conectamos con el service principal.
az login --service-principal \
         --username "appId"  \
         --password "password"  \
         --tenant "tenant"

#7 Revisamos la lista de las cuentas disponibles.
az account list

#8 Revisamos la lista disponible de locaciones.
az account list-locations --query '[].name'

#9 Creamos un Resource Group.
az group create -l centralus -n dev-step6-rg

#10 Creamos un cluster de k8s.
az aks create -g dev-step6-rg -n CoolClusterStep6 --node-count 1

#11 Ver la lista de Clusters creados.
az aks list -o table

#12 Vamos al cluster en el Azure Portal.
az aks browse -n CoolClusterStep6 -g dev-step6-rg

#13 Actualizamos su ~/.kube/config para conectarnos con kubectl.
az aks get-credentials -g dev-step6-rg -n CoolClusterStep6

#14 Ver la lista de NodePools.
az aks nodepool list  --cluster-name CoolClusterStep6 --resource-group dev-step6-rg

#15 Escalamos el cluster a 1 nodo.
az aks nodepool scale --cluster-name CoolClusterStep6 --name nodepool1 --resource-group dev-step6-rg --node-count 1

#16 Agregamos otro Nodepool.
az aks nodepool add \
    --resource-group dev-step6-rg \
    --cluster-name CoolClusterStep6 \
    --name otro \
    --node-count 1

#17 Creamos un deployment con python-service.
kubectl apply -f k8s/hola-deployment.yml

#18 Creamos un service para poder accesar python-service.
kubectl apply -f k8s/hola-svc.yml

#19 Obtenemos la IP Publica del svc.
kubectl get svc

#20 Vamos al Servicio expuesto en la nube.
http://20.98.179.165:2000/hello

#21 Eliminamos todo lo que creamos en el ejercicio. 
az aks delete -n CoolClusterStep6 -g dev-step6-rg
az group delete -n dev-step6-rg
