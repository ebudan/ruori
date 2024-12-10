This project is configured to use the [Chart Releaser](https://helm.sh/docs/howto/chart_releaser_action/) to automatically
update a Helm chart index published at [https://ebudan.github.io/ruori/](https://ebudan.github.io/ruori/). 

If a `helm repo update ruori` doesn't seem to work, this is how to troubleshoot. 

First - did you update the chart version in `Chart.yaml`?

If so: navigate to the [actions](https://github.com/ebudan/ruori/actions) section of the repository. 

Check for a failed run in the workflow list. Click to open.

In the `release.yml` section of the page, click on an error taglet to open the run view.

In the top right corner, click on the settings cogwheel and select *View raw logs*. 

Based on the output of the releaser run, you may need to update `./.github/workflows/release.yml` options. 
Commit and observe the re-run. 

