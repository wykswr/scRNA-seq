process SaveResult {
  label 'scanpy'
  input:
  path pbmcH5ad
  script:
  """
  #!/usr/bin/env python

  import scanpy as sc
  import os

  adata = sc.read_h5ad("${pbmcH5ad}")
  os.makedirs("${params.output}/result", exist_ok=True)
  adata.write_h5ad('${params.output}/result/pbmc.h5ad')
  """
}