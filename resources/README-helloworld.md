
A simple, one-container equivalent of a sample_ses_deploy.yaml 
setup, used to narrow down how we should work with tester/traefik
using default helm charts. 

    helm template \
    --set traefik.InstanceLabelOverride=ingresscontroller \
    myinstance ./charts/helloworld >tmp/deploy-helloworld.yaml
