rule all:
    input:
        expand('mapped_reads/{sample}.bam', sample=['A','B','C','D'])

rule bwa_map:
    input:
        'data/genome.fa',
        'data/samples/{sample}.fastq'
    output:
        'mapped_reads/{sample}.sam'
    log:
        'logs/bwa_map/bwa_map_{sample}.log'
    conda:
        'envs/bwa_map.yaml'
    shell:
        "bwa mem {input} > {output}"

rule convert_sam_bam:
    input:
        'mapped_reads/{sample}.sam'
    output:
        bam='mapped_reads/{sample}.bam'
    log:
        'logs/convert_sam_bam/convert_sam_bam_{sample}.log'
    wrapper:
        "v8.1.1/bio/samtools/view"

