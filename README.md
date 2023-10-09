# Ruori

Helm charts for prototype projects. 

This project is configured to use the [Chart Releaser](https://helm.sh/docs/howto/chart_releaser_action/) to automatically
update a Helm chart index published at [https://ebudan.github.io/ruori/](https://ebudan.github.io/ruori/). 

## Structure

Each functional helm chart directory must reside in `./charts/`. The automated push action will regenerate
the chart index. Please provide a `resources/README-chartname.md` to help use any complicated charts. 

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

    helm repo add ruori https://ebudan.github.io/ruori/

Check available charts with `helm search repo ruori`. 
Check documentation under `./resources` for the chart. 

To generate a templated deployment, you will usually perform

    KEY=val helm myinstance ruori/chartname >k8s-deployment.yaml

Since the reusable templates require several variables, a Taskfile example will usually be provided. 

