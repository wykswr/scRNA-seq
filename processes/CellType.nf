process CellType {
  label 'scanpy'
  input:
  path pbmcH5ad
  output:
  path 'pbmc.h5ad'
  script:
  """
  #!/usr/bin/env python

  import scanpy as sc
  import os
  import matplotlib.pyplot as plt

  adata = sc.read_h5ad("${pbmcH5ad}")
  ref = sc.datasets.pbmc3k_processed()
  var_names = ref.var_names.intersection(adata.var_names)
  ref = ref[:, var_names]
  adata.write_h5ad('pbmc.h5ad')
  """
}