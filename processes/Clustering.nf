process Clustering {
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

  adata = sc.read_h5ad('${pbmcH5ad}')
  sc.pp.neighbors(adata, n_neighbors=10, n_pcs=40)
  sc.tl.umap(adata)
  sc.tl.louvain(adata)
  sc.pl.umap(adata, color='louvain')
  os.makedirs('${params.output}/clustering', exist_ok=True)
  plt.savefig('${params.output}/clustering/louvain.png')
  plt.clf()
  adata.write('pbmc.h5ad')
  """
}