# Ruori

Helm charts for prototype projects. 

## Structure

Each Helm chart ID resides in its own subdirectory. A `README-{id}.md` must be provided for usage examples.  

To deploy an artefact:

    git checkout gh-pages
    helm package 

Artefacts are generated with the [Chart Releaser](https://helm.sh/docs/howto/chart_releaser_action/) action under `./charts`.


## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

  helm repo add ruori https://ebudan.github.io/ruori/helm-charts

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
<alias>` to see the charts.

To install the <chart-name> chart:

    helm install my-<chart-name> <alias>/<chart-name>

To uninstall the chart:

    helm delete my-<chart-name>