#!/usr/bin/env nextflow
nextflow.enable.dsl=2

include {QC} from './processes/QC'
include {PCA} from './processes/PCA'
include {Clustering} from './processes/Clustering'
include {CallMarkerGene} from './processes/CallMarkerGene'
include {CellType} from './processes/CellType'
include {SaveResult} from './processes/SaveResult'


workflow {
  File outpath = new File(params.output)
    if (!outpath.exists())
        outpath.mkdirs()
  ch_mat = channel.fromPath(params.countMat)
  ch_mat | QC | PCA | Clustering | CallMarkerGene | SaveResult
}