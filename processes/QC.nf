process QC {
  label 'scanpy'
  input:
  path countMatDir
  output:
  path 'pbmc.h5ad'
  script:
  """
  #!/usr/bin/env python

  import scanpy as sc

  adata = sc.read_10x_mtx('${countMatDir}', var_names='gene_symbols', cache=True)
  adata.var_names_make_unique()

  sc.pp.filter_cells(adata, min_genes=200)
  sc.pp.filter_genes(adata, min_cells=3)
  adata.var['mt'] = adata.var_names.str.startswith('MT-')
  sc.pp.calculate_qc_metrics(adata, qc_vars=['mt'], percent_top=None, log1p=False, inplace=True)
  adata = adata[adata.obs.n_genes_by_counts < 2500, :]
  adata = adata[adata.obs.pct_counts_mt < 5, :]
  sc.pp.normalize_total(adata, target_sum=1e4)
  sc.pp.log1p(adata)
  sc.pp.highly_variable_genes(adata, min_mean=0.0125, max_mean=3, min_disp=0.5)

  adata.raw = adata
  adata = adata[:, adata.var.highly_variable]
  sc.pp.regress_out(adata, ['total_counts', 'pct_counts_mt'])
  sc.pp.scale(adata, max_value=10)
  adata.write('pbmc.h5ad')
  """
}