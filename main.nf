#!/usr/bin/env nextflow

nextflow.enable.dsl=1

fastq_files = Channel.fromPath(params.in, type: 'file')

process sortbyname {
    //errorStrategy 'ignore'
    cpus 4
    memory '16 GB'
    publishDir params.out, mode: 'copy', overwrite: true

    input:
    file fastq from fastq_files
 
    output:
    path "Paired_${fastq}"
    """
    sortbyname.sh in=${fastq} out=Paired_${fastq.baseName}
    bgzip -@ 4 Paired_${fastq.baseName}
    """
}

