
# Despliegue de ElasticSearch en Kubernetes

### Instalación de kubernetes con k3s

[Kubernetes: Despliega un cluster barato para una pequeña empresa en minutos con k3s en AWS](https://omarburgosb.medium.com/kubernetes-despliega-un-cluster-barato-para-una-peque%C3%B1a-empresa-en-minutos-con-k3s-en-aws-9250e53351e6)

https://www.guidgenerator.com/

Primer servidor:

```
curl -sfL https://get.k3s.io | sh -s server --cluster-init --token '{token}' --disable=traefik --node-external-ip={ip-publica}  
```
Otros Servidores
```
curl -sfL https://get.k3s.io | K3S_TOKEN={token} sh -s server --server https://{ip-primer-servidor}
```

Para dar permisos al usuario ubuntu de leer el archivo de kubernetes

```
sudo chown ubuntu /etc/rancher/k3s/k3s.yaml
```

### Instalar Elastic Cloud Kubernetes 
https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-eck.html
```
kubectl create -f https://download.elastic.co/downloads/eck/1.7.1/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/1.7.1/operator.yaml
```

### Etiquetar los servidores para dividirlos por data center
```
kubectl label node {node-name}  datacenter=dc-1
kubectl label node {node-name}  datacenter=dc-2
kubectl label node {node-name}  datacenter=dc-3
```

### Despliegue de Elastic Stack

El siguiente comando creará tres instancias de Elastic Search y una de kibana:
```
kubectl apply -f./elastic-search/
```

Enterprise Search:
```
kubectl apply -f./enterprise-search/
```

###  Despliegue de Elastic Stack para Monitoreo
```
kubectl apply -f./monitoring/
``` 
### Instalación de cert-manager

https://cert-manager.io/docs/installation/kubernetes/

```
helm repo add jetstack https://charts.jetstack.io
helm repo update

helm upgrade --install \
 cert-manager jetstack/cert-manager \
 --namespace cert-manager \
 --create-namespace \
 --version v1.3.0 \
 --set installCRDs=true 
```

Crear issuer para generar certificado con Route53
```
kubectl apply -f ./certmanager/issuer
kubectl apply -f ./certmanager/certificates
```
