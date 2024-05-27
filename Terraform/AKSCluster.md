# Create AKS Cluster
## Create a resource group
```
az group create -n rg-NAME-dev-001 -l uksouth
```

## Create AKS cluster, with the default linux nodepool
```
az aks create -g rg-NAME-dev-001 -n win-aks-uksouth-001 \
  --node-count 3 --generate-ssh-keys \
  --windows-admin-username NAMEadmin \
  --windows-admin-password locate on kvNAME001 \
  --network-plugin azure \
  --node-vm-size Standard_E4s_v5 \
  --attach-acr NAMEContainerRegistry
```

# Optional windows Node Pool
## Create a second nodepool using Windows
```
 az aks nodepool add -g rg-NAME-dev-001 \
  --cluster-name win-aks-uksouth-001 \
  --os-type Windows --name win001 \
  --node-count 1 \
  --node-vm-size Standard_E2s_v5
```

# Create Kakfa Cluster using Strimzi
Connect to AKS Cluster following azure portal instructions

## Create namespace
```
kubectl create namespace kafka-operator
```

## Create RBAC for Kafka Cluster
```
kubectl create clusterrolebinding strimzi-cluster-operator-namespaced --clusterrole=strimzi-cluster-operator-namespaced --serviceaccount kafka-operator:strimzi-cluster-operator
```

```
kubectl create clusterrolebinding strimzi-cluster-operator-entity-operator-delegation --clusterrole=strimzi-entity-operator --serviceaccount kafka-operator:strimzi-cluster-operator
```

## Install Kafka Cluster Operator
```
kubectl create -f Kafka/strimzi-0.26.0/install/cluster-operator -n kafka-operator
```

## Create Kafka Cluster
```
kubectl create -f Kafka/kafka-aks.yml
```

## Create Kafka Topic
```
kubectl create -f Kafka/kafka-topic.yml
```

# Vertically scale the cluster

[Source](https://docs.microsoft.com/en-us/azure/aks/scale-cluster)

## Get the name of the node pool
### For Dev Environment
```
az aks show --resource-group rg-NAME-dev-001 --name win-aks-uksouth-001 --query agentPoolProfiles
```
### For SIT Environment
```
az aks show --resource-group rg-NAME-sit-uks --name aks-NAME-sit-uks --query agentPoolProfiles
```

## Scale the the cluster ndoes

### For DEV Environment
```
az aks scale --resource-group rg-NAME-dev-001 --name win-aks-uksouth-001 --node-count 4 --nodepool-name nodepool1
```
### For SIT Environment
```
az aks scale --resource-group rg-NAME-sit-uks --name aks-NAME-sit-uks --node-count 4 --nodepool-name nodepool1
```
Note: [For VMWare Tanzu](https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-7992B7F6-9174-44F4-99BE-C0B5C45FA2EC.html#scale-out-worker-nodes-3)

# Configure Auto Scaler

### For DEV Environment
```
az aks update \
  --resource-group rg-NAME-dev-001 \
  --name win-aks-uksouth-001 \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 3
```
### For SIT Environment
```
az aks update \
  --resource-group rg-NAME-sit-uks \
  --name aks-NAME-sit-uks \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 3
```
# For pod termination
```
kubectl delete <name> --force --grace-period=0
```
or
```
kubectl delete <name> --now
```
