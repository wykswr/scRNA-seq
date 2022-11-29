process Visualization {
  label 'scanpy'
  input:
  path pbmcH5ad
  script:
  """
  #!/usr/bin/env python

  import scanpy as sc
  import matplotlib.pyplot as plt

  adata = sc.read_h5ad("${pbmcH5ad}")
  sc.pl.umap(adata, color="Annotation")
  plt.axis('tight')
  plt.savefig('${params.output}/Annotation.png', bbox_inches='tight')
  plt.clf()
  adata.write_h5ad('${params.output}/pbmc.h5ad')
  """
}