rule all:
    input:
        expand("mapped_reads/{sample}.sorted.bam", sample=["A","B","C","D"])

rule bwa_map:
    input:
        "data/genome.fa",
        "data/samples/{sample}.fastq"
    output:
        "mapped_reads/{sample}.sam"
    benchmark:
        "benchmark/bwa_map/{sample}.bench.txt"
    conda:
        "envs/bwa_map.yaml"
    threads: 20
    shell:
        "bwa mem -t {threads} {input} > {output}"

rule convert_sam_bam:
    input:
        "mapped_reads/{sample}.sam"
    output:
        "mapped_reads/{sample}.bam"
    conda:
        "envs/convert_sam_bam.yaml"
    threads: 20
    shell:
        "samtools view -Sb {input} > {output}"

rule samtools_sort:
    input:
        "mapped_reads/{sample}.bam"
    output:
        "mapped_reads/{sample}.sorted.bam"
    wrapper:
        "v9.0.0/bio/samtools/sort"