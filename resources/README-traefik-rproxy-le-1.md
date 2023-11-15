# traefik-rproxy-le-1

This is a chart for deploying Traefik as a domain name based rproxy DaemonSet with automatic Let's Encrypt certificate generation and namespacing.  

This proxy only runs on the master node; running a distributed ingress will require a business license and/or solving distributed certificate storage. 

To deploy a namespaced app behind this rproxy, see [README-helloworld.md].  
To deploy a multiple container app along SES guidelines, see [README-ses.md]. 

## Prerequisites

### Traefik custom resources

The [traefik custom resource definitions](https://doc.traefik.io/traefik/reference/dynamic-configuration/kubernetes-crd/#definitions) must be deployed on the `K*S` instance. We provide a snapshot from 2023-10-20 here: 

* [kubernetes-crd-definition-v1.yml](kubernetes-crd-definition-v1.yml)
* [kubernetes-crd-rbac.yml](kubernetes-crd-rbac.yml)

To apply on the server:

    kubectl apply -f $RESOURCE_FILE

### This repository

If not using a local copy, make helm aware of this repository:

    helm repo add ruori https://ebudan.github.io/ruori/


## Building a deployment

Use the provided Taskfile:

    LEEMAIL=your-acme@email.net INSTANCE=traefik-ingress HOSTPATH=/data/services/traefik-ingress task -t ./resources/Taskfile-traefik-rproxy-le-1.yml 

(The task performs some additional replacements that the stock Traefik chart does not want to support.)

If you need manual intervention, this is what the Taskfile does:

    helm template \
    --set traefik.persistence.hostpath=$HOSTPATH \
    --set traefik.instanceLabelOverride=$TRAEFIK_INSTANCE \
    --set traefik.namespaceOverride=$TRAEFIK_INSTANCE \
    --set traefik.certResolvers.letsencrypt.email=$EMAIL \
    $TRAEFIK_INSTANCE ruori/traefik-rproxy-le-1 >deploy-$TRAEFIK_INSTANCE.yml

We use `$TRAEFIK_INSTANCE` as a unique ID for the rproxy and its namespace.  
Note that we must specify the overrides as above; the traefik template generates unreliable defaults if we don't.  
This `$TRAEFIK_INSTANCE` value will be required when you deploy an app with other charts (ruori/helloworld, ruori/ses).  
At this writing, our default installation uses `TRAEFIK_INSTANCE=traefik-ingress`. Your setup may vary.  

The `$HOSTPATH` must be a prepared master-node location to store Let's Encrypt certificates. 

This chart uses HostSNI to serve valid DNS addresses; deployed apps will inform Traefik of their routing, and Traefik will retrieve certificates from LetsEncrypt. Specify your `$EMAIL` accordingly. 

You may further want to adjust `charts/traefik-rproxy-le-1/values.yaml` settings, for example:

    --set traefik.logs.general.level=ERROR



## Adding accessible ports

This chart provides ingress 443 (websecure) and additional access to ports 8883 (mqtt) and 9443 (autentica). If your deployment requires more, you will have to customize this chart or provide additional setup flags, then regenerate the deployment. 


## Caveats

This chart sets Traefik up as a Let's Encrypt capable reverse-proxy/ingress, BUT certificate persistence combined 
with the non-commercial traefik version restrict our options - it is not HA, but instead limited to the master node.

## To Do

- Prometheus doesn't get disabled (Helm empty override propagation bug/feature)

