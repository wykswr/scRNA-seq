process CallMarkerGene {
  label 'scanpy'
  input:
  path pbmcH5ad
  output:
  path 'markerGenes.csv'
  script:
  """
  #!/usr/bin/env python

  import scanpy as sc
  import os
  import matplotlib.pyplot as plt

  adata = sc.read_h5ad('${pbmcH5ad}')
  sc.tl.rank_genes_groups(adata, 'louvain', method='wilcoxon')
  result = adata.uns['rank_genes_groups']
  groups = result['names'].dtype.names
  dat = pd.DataFrame({group + '_' + key[:1]: result[key][group] for group in groups for key in ['names', 'logfoldchanges','scores','pvals']})
  dat.to_csv("markerGenes.csv")
  """
}