Initial chart structure for SES -> deployment descriptor. 

NOT FUNCTIONAL 

We use `ses subst` to generate an initial `values.yaml`.  
That setup is then used with the `ses` helm chart to generate the final descriptor.  

    ses subst --in ses-values.tmpl --out customvalues.yaml
    helm template -f customvalues.yaml foobar ruori/ses >sample-descriptor.yaml

Note that we encode container secrets into the descriptor, which suits our current use case but is not generally the best of ideas. (Further work on skrt mgmt required.)  

Note also that we must somehow pre-generate two particular secret files, the `backbone.acl` and `userdb.yaml`, and inject those. 
This process is still undefined.