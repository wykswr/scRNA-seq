process CallMarkerGene {
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
  sc.tl.rank_genes_groups(adata, 'louvain', method='wilcoxon')
  sc.pl.rank_genes_groups(adata, n_genes=25, sharey=False)
  os.makedirs('${params.output}/makerGenes', exist_ok=True)
  plt.savefig('${params.output}/makerGenes/pbmc.png')

  adata.write('pbmc.h5ad')
  """
}