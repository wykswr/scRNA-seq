# PBMC scRNA-seq cell type annotation
## Introduction
scRNA-seq has revolutionized the developmental and genetic research in cell level, not only it reveals the cellular genes expression in impressively high precision, but it also can infer the interaction among those cells, obtaining compelling insights about biological mechanism. Some typical instances include cell type annotation and cell differentiation trajectory inference.

In this workflow, we are undertaking the cell type annotation, the dataset can be very generic 10x genome dataset. For demonstration, a PBMC3k dataset is used as show case. Briefly speaking, Human peripheral blood mononuclear cells (PBMCs) dataset is comprised of immune cells with a single, round nucleus that originate in bone marrow and are secreted into peripheral circulation. These cells are critical components of the immune system and are involved in both humoral and cell-mediated immunity, so the cell type portion often encodes some disease related information.

### Background

### Purpose
To find the marker genes for each cell type in scRNA-seq dataset (PBMC is used for demo), and do cell type annotation on the dataset.
## Workflow
### Diagram
### Dependencies
We use Singularity container to make the workflow more portable and robust. 2 main containers are required to set the environment:
1. docker://nfcore/cellranger:6.1.2
    * Image is stored on dockerhub
    * Cellranger version: 6.1.2
2. library://wykswr/biof501/sc-rna:1.0
    * Image is stored on Sylabs
    * scanpy
    * MACA

You should [install Singularity](https://docs.sylabs.io/guides/3.0/user-guide/installation.html) on your platform in order to run this pipeline.
### Usage
### Output
* Clustering.png: The result of KNN clustering on the quality-controlled PBMC dataset.
* MarkerGenes.csv: The marker genes of each cluster, ranked increasingly by p-value.
* Annotation.png: The UMAP visualization of cell type annotated dataset.
* pbmc.h5ad: The meta-dataset, containing the raw data, highly variated genes, high quality cells, PCs, cluster labels, and cell type annotation.