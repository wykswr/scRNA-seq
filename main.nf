#!/usr/bin/env nextflow
nextflow.enable.dsl=2

include {QC} from './processes/QC'
include {PCA} from './processes/PCA'
include {Clustering} from './processes/Clustering'
include {CellType} from './processes/CellType'
include {Visualization} from './processes/Visualization'


workflow {
  File outpath = new File(params.output)
    if (!outpath.exists())
        outpath.mkdirs()
  ch_mat = channel.fromPath(params.countMat)
  ch_mat | QC | PCA | Clustering | CellType | Visualization
}