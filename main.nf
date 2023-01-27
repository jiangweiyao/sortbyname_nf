#!/usr/bin/env nextflow

fastq_files = Channel.fromPath(params.in, type: 'file')

process sortbyname {
    conda "/home/ubuntu/sortbyname_nf/environment.yml"
    maxForks 1
    //errorStrategy 'ignore'
    publishDir params.out, mode: 'copy', overwrite: true

    input:
    file fastq from fastq_files
 
    output:
    path "Paired_${fastq}"
    """
    sortbyname.sh in=${fastq} out=Paired_${fastq.baseName}
    bgzip Paired_${fastq.baseName}
    """
}

