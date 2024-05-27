## Pre-requisites
The solution requires the following:
- Docker Desktop (Kubernetes enabled)
- .NET 6
- PowerShell


## Building

To compile the solution locally, run the following command from the root of the repo:

```
.\Build.ps1
```

This script will execute the default commands to compile the solution with Debug configuration.


The script can accept a number of arguments:

`.\Build.ps1 Clean` - Clean all output and temporary build locations

`.\Build.ps1 Build` - Compile solution. Will use default "Debug" configuration

`.\Build.ps1 Build Debug` - Compile solution with Debug configuration

`.\Build.ps1 Test` - Run all tests created in the "Unit" test category

`.\Build.ps1 Deploy` - Compile solution, publish and create container on local Docker for Desktop


## Local Deploy

Details on installing Kafka locally are detailed in the file:
- \\Infrastructure\Kafka\kafka install instructions.txt

To deploy the solution locally run the following PowerShell command from the root of the repo:

```
.\DeployLocal.ps1
```

or, to skip compiling solution and uses last build output

```
.\DeployLocal.ps1 -SkipDotNetBuild
```

To teardown the local installation run the following:

```
.\UndeployLocal.ps1
```

# Troubleshooting

## Switching kubectl to local Docker for Desktop after doing some fun AKS configuration

You can switch from local (Docker Desktop or minikube) to AKS and back with:

```
kubectl config use-context CONTEXT_NAME
```

to list all contexts:

```
kubectl config get-contexts
```