

Tester is a simplified version of traefik, where I try to hunt down 
all complications of namespaced, LetsEncrypted, TLS-passthrough 
services before committing changes to traefik.

We are working with helloworld from the other end to see how 
the policies should be built. 

Remaining bugs:
- A bunch of unnecessary ports are not removed (traefik modified subchart 
  should explicitly remove them from values)
- Prometheus doesn't get disabled


To build a Traefik template: 

    helm template \
    --set traefik.persistence.hostpath=/data/services/traefik-ingress \
    --set traefik.instanceLabelOverride=ingresscontroller \
    myinstance ./charts/tester >tmp/deploy-tester.yaml

To build a sample app template, see [README-helloworld.md].



Other:

Warning: resource serviceaccounts/default is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.