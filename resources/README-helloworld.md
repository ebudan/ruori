
This is a simple chart to demonstrate deploying a trivial app with `traefik-rproxy-le-1` as the ingress. 

A simple, one-container equivalent of a sample_ses_deploy.yaml 
setup, used to narrow down how we should work with tester/traefik
using default helm charts. 

## Usage

Add/update this repository:

    helm repo add ruori https://ebudan.github.io/ruori/
    helm repo update ruori

Using the `$INSTANCE` that was used to deploy a `traefik-rproxy-le-1`:

    helm template \
    --set traefik.instanceLabelOverride=$TRAEFIK_INSTANCE \
    --set traefik.namespace=$TRAEFIK_INSTANCE \
    --set namespace=$INSTANCE \
    $INSTANCE ruori/helloworld >deploy-helloworld.yaml

Note above that we _must_ specify the `instanceLabelOverride` and `traefik.namespace` to match the values used in generating our Traefik proxy. 
We must also assign ourselces a unique APPID used for the namespace and deployment name on our cluster. 

A `Taskfile-helloworld.yml` helper has been prepared:

    INSTANCE=xxx TRAEFIK_INSTANCE=yyy task -t resources/Taskfile-helloworld.yml

Deploy the artefact on your cluster. Optionally configure the cluster to accept direct helm connections. 

## To DO

- INSTANCE is used as namespace without filtering. Be conservative with the naming, or add templating to cope. (Note - also occurs in 3rd party Traefik chart.)
