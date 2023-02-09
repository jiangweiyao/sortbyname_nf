#!/usr/bin/env nextflow

nextflow.enable.dsl=1

fastq_files = Channel.fromPath(params.in, type: 'file')

process sortbyname {
    //errorStrategy 'ignore'
    cpus 8
    memory '64 GB'
    publishDir params.out, overwrite: true

    input:
    file fastq from fastq_files
 
    output:
    path "Paired_${fastq}"
    """
    sortbyname.sh in=${fastq} out=Paired_${fastq.baseName} -Xmx62g
    bgzip -@ 8 Paired_${fastq.baseName}
    """
}

