# PBMC scRNA-seq cell type annotation

- [PBMC scRNA-seq cell type annotation](#pbmc-scrna-seq-cell-type-annotation)
  - [Introduction](#introduction)
    - [Background](#background)
    - [Purpose](#purpose)
  - [Workflow](#workflow)
    - [Diagram](#diagram)
    - [Dependencies](#dependencies)
    - [Usage](#usage)
    - [Input](#input)
    - [Data](#data)
    - [Output](#output)

## Introduction
### Background
scRNA-seq has revolutionized the developmental and genetic research in cell level, not only it reveals the cellular genes expression in impressively high precision, but it also can infer the interaction among those cells, obtaining compelling insights about biological mechanism. Some typical instances include cell type annotation and cell differentiation trajectory inference.

In this workflow, we are undertaking the cell type annotation, the dataset can be very generic 10x genome dataset. For demonstration, a PBMC3k dataset is used as show case. Briefly speaking, human peripheral blood mononuclear cells (PBMCs) dataset is comprised of immune cells with a single, round nucleus that originate in bone marrow and are secreted into peripheral circulation. These cells are critical components of the immune system and are involved in both humoral and cell-mediated immunity, so the cell type portion often encodes some disease related patterns.

In a typical scRNA-seq cell type annotation pipeline, the starting point is a gene count matrix, with rows as cells and columns as genes. Sometime researchers need to start from the raw sequencing data, tools such as the Cellranger are needed to convert the fastq files to gene count matrix.
The first step is doing the quality control, removing the uninformative cells and genes and abate the batch effect. in next step, principal component analysis (PCA) and uniform manifold approximation and projection (UMAP) are applied to find the lower dimensional representation of the genes profile. And the we do a k-nearest neighbors (KNN) clustering on that representation, use wilcoxon test to find the marker genes within each cluster, eventually get the cell type annotation after comparing to marker genes database.

### Purpose
To find the marker genes for each cell type in scRNA-seq dataset (PBMC is used for demo), and do cell type annotation on that dataset.
## Workflow
### Diagram
<p align="center">
  <img src="workflow.drawio.svg" alt="workflow diagram"/>
</p>
### Dependencies
We use Singularity container to make the workflow more portable and robust. 2 main containers are required to set the environment:
1. docker://nfcore/cellranger:6.1.2
    * Image is stored on [dockerhub](https://hub.docker.com/r/nfcore/cellranger/tags)
    * Cellranger version: 6.1.2
2. library://wykswr/biof501/sc-rna:1.0
    * Image is stored on [Sylabs](https://cloud.sylabs.io/library/wykswr/biof501/sc-rna)
    * scanpy
    * MACA

You should [install Singularity](https://docs.sylabs.io/guides/3.0/user-guide/installation.html) on your platform in order to run this pipeline.
### Usage
If you are testing the pipeline on server of BIOF501, go to the project's directory, and type in:

`./main.nf`

Then find the all results in the output folder.

If you start analysis from the fastq files, the API is:

`./main.nf --denovo true --fastqs <path of directory> --reference <path> --markerRef <path> --output <path of directory>`

However, converting format using Cellranger may consume several hours, if you want to start from the gene count matrix, please use this API:

`./main.nf --countMat <path> --markerRef <path> --output <path of directory>`
### Input
* fastqs: Raw sequencing files in fastq format from [10Xgenomics](https://www.10xgenomics.com).
* reference: A transcriptomics reference sequenc.
* countMat: Gene count matrix.
* markerRef: A CSV file which tells the marker genes of listed cell type.
### Data

### Output
* Clustering.png: The result of KNN clustering on the quality-controlled PBMC dataset.
* MarkerGenes.csv: The marker genes of each cluster, ranked increasingly by p-value.
* Annotation.png: The UMAP visualization of cell type annotated dataset.
* pbmc.h5ad: The meta-dataset, containing the raw data, highly variated genes, high quality cells, PCs, cluster labels, and cell type annotation.
