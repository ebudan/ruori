# ses - ses-modules-behind-traefik-rproxy-with-LE

This chart generates a SES app deployment designed to work with a `ruori/traefik-rproxy-le-1` charted ingress controller. 

First, you must have a valid SES environment; see [SES documentation](https://github.com/basen/ses-base/). 

Then, you generate an interim descriptor:

    ses deployment helm >ses-values-myproject-20250101-1.yaml

Finally, to generate the deployment:

    helm template -f ses-values-myproject-20250101-1.yaml \
    --set traefik.instance=$TRAEFIK_INSTANCE \
    foobar ruori/ses >ses-deployment-myproject-20250101-1.yaml

Here, TRAEFIK_INSTANCE is the identifier of the rproxy instance as used with `helm ruori/traefik-rproxy-le-1`. That descriptor must be deployed on your cluster (along with the appropriate resource definitions, see ../resources) first, followed by `ses-deployment-myproject-20250101-1.yaml` to run that ses instance.  

Note that we encode container secrets into the descriptor, which suits our current use case but is not generally the best of ideas. (Further work on skrt mgmt required.)  
