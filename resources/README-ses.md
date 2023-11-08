# ses - ses-modules-behind-traefik-rproxy-with-LE

This chart generates a SES app deployment designed to work with a `ses-traefik-le-1` charted ingress controller. 

First, you must have a valid SES environment; see [SES documentation](https://github.com/basen/ses-base/). 

Then, you generate an interim descriptor:

    ses deployment helm >ses-values.yaml

Finally, to generate the deployment:

    helm template -f ses-values.yaml \
    --set traefik.instance=$TRAEFIK_INSTANCE \
    foobar ruori/ses >my-deployment.yaml

Here, TRAEFIK_INSTANCE is the identifier of the rproxy instance generated with `helm ruori/traefik-rproxy-le-1`. 

Note that we encode container secrets into the descriptor, which suits our current use case but is not generally the best of ideas. (Further work on skrt mgmt required.)  
