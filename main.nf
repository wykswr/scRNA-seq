#!/usr/bin/env nextflow
nextflow.enable.dsl=2

include {QC} from './processes/QC'
include {PCA} from './processes/PCA'
include {Clustering} from './processes/Clustering'
include {CellType} from './processes/CellType'
include {Visualization} from './processes/Visualization'
include {ConvertRaw} from './processes/ConvertRaw'


workflow {
  File outpath = new File(params.output)
    if (!outpath.exists())
        outpath.mkdirs()
  if (params.denovo) {
    ch_mat = ConvertRaw(Channel.fromPath(params.fastqs), Channel.fromPath(params.reference))
  } else {
    ch_mat = Channel.fromPath(params.countMat)
  }
  ch_mat | QC | PCA | Clustering | CellType | Visualization
}