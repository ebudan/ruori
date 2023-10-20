
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
    --set traefik.instanceLabelOverride=$INSTANCE \
    --set traefik.namespace=$INSTANCE \
    --set namespace=$APPID \
    $APPID ruori/helloworld >deploy-helloworld.yaml

Note above that we _must_ specify the `instanceLabelOverride` and `traefik.namespace` to match the values used in generating our Traefik proxy. We must also assign ourselces a unique APPID used for the namespace and deployment name on our cluster. 

Deploy the artefact on your cluster. Optionally configure the cluster to accept direct helm connections. 
