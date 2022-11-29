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
  import pandas as pd
  import MACA as maca

  adata = sc.read_h5ad('${pbmcH5ad}')
  sc.tl.rank_genes_groups(adata, 'louvain', method='wilcoxon')
  pd.DataFrame(adata.uns['rank_genes_groups']['names']).to_csv('${params.output}/MakerGenes.csv', index=False)
  markers = pd.read_csv("${params.markerRef}")
  cell_markers = dict()
  for m in markers.columns:
    cell_markers[m]=markers[m].values.tolist()
  marker_list = []
  for _, v in cell_markers.items():
    marker_list += v
  marker_list = list(set(marker_list))
  marker_list = [i for i in marker_list if i in adata.var.index]
  ad = adata[:,marker_list]
  ad, annotation = maca.singleMACA(ad=ad, cell_markers=cell_markers, res=[1,2,3],n_neis=[3,5,10])
  adata.obs['Annotation']=annotation
  adata.obsm['X_umap']=ad.obsm['X_umap']
  adata.write_h5ad('pbmc.h5ad')
  """
}