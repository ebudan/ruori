# tnssca - Traefik-Name-Spaced-Single-Container-App

This is a Helm chart for deploying 

* a single-container, non-scaling app
* behind a Traefik front-end (configured separately)
* using LetsEncrypt
* in a private namespace
* with secrets


## Usage

You may wish to

    source <(helm completion bash)
    helm repo add ruori https://ebudan.github.io/ruori/

...if you prefer that to using this chart locally.

A sample invocation, as used in the `Taskfile.yml` here:

        helm template \
          --set image.repository="quay.io/basen/lm-trainn" \
          --set image.tag="v1.0.0" \
          --set nameOverride="myinstance" \
          --set fullnameOverride="myinstance" \
          --set mount.dirs="{ data:/data/services/foo:/usr/share/data }" \
          --set mount.secrets="/etc/myinstance/secrets" \
          --set deplEnv.ADMIN=blame@me.com \
          --set deplEnv.HOST=fqdn.net \
          --set appEnv.APP_QUEUE_DIR="/usr/share/data" \
          --set appEnv.APP_PASSWORDFILE="/etc/myinstance/secrets/auth.txt" \
          --set appEnv.APP_PORT=80 \
          --set appEnv.APP_LOGLEVEL="debug" \
          --set appEnv.APP_NOTLS="true" \
          --set-file secrets.auth\\.txt=setup/passwd.txt \
          myinstance ruori/tnssca > mydeployment.yaml

Here, the following variables are mandatory:

* `image.repository`: the image (accessible to deployment cluster) to use.
* `image.tag`: the image version to use. Do not use `latest`.
* `nameOverride`, `fullnameOverride`: must be the same as the helm instance, here `myinstance`. This value is used to set up service name, namespace, and networking details. 
* `mount.dirs`: a comma-separated list of `name:host/path:container/path` to mount on cluster nodes
* `mount.secrets`: a location to mount any secret files present in `./tnssca/secrets` at deployment generation time
* `deplEnv.ADMIN`: an admin email address to blame
* `deplenv.HOST`: a FQDN for this service
* `appEnv.*`: any number of ENV to provide to the container runtime
* `secrets.KEY=FILE`: any number of secrets-files to include in deployment, available under `mount.secrets` in runtime

## Notes

Here we assume a Traefik front-end taking care of rproxy/LetsEncrypt details. See the [SES project](https://github.com/base/ses-cli) for a sample setup.  
This chart is not SES-dependent, it just uses Traefik in the same way to route host based traffic to the container.

For Helm documentation, see [Helm docs](https://helm.sh/docs/). The template language is Go augmented with [slim-sprig](https://go-task.github.io/slim-sprig/). 

This is a first attempt at a Helm chart - it is not very dynamic, especially with the networking aspect, and it has not been pared 
down to essentials or cleaned up. Improvements TBD.
