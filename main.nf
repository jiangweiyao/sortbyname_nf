#!/usr/bin/env nextflow

nextflow.enable.dsl=1

fastq_files = Channel.fromPath(params.in, type: 'file')

process sortbyname {
    //errorStrategy 'ignore'
    cpus 16
    memory '120 GB'
    publishDir params.out, overwrite: true

    input:
    file fastq from fastq_files
 
    output:
    path "Paired_${fastq}"
    """
    sortbyname.sh in=${fastq} out=Paired_${fastq.baseName} -Xmx120g
    bgzip -@ 16 Paired_${fastq.baseName}
    """
}

