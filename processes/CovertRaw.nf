process CorverRaw {
  label 'cellranger'
  input:
  path 'fastqDir'
  path 'transcriptomeRef'
  output:
  path 'task/outs/filtered_feature_bc_matrix'
  script:
  """
  #!/usr/bin/env bash

  cellranger count --id=task \
   --fastqs=fastqDir \
   --transcriptome=transcriptomeRef
  """
}