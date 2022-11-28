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

  adata = sc.read_h5ad("${pbmcH5ad}")
  
  """
}