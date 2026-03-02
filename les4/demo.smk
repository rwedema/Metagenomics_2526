rule all:
    input:
        "plots/plot_A.svg"

rule get_fasta:
    output:
        "demo-results/test.fasta"
    params:
        id="KY785484",
        db="nuccore",
        format="fasta",
        mode=None
    wrapper:
        "v7.0.0/bio/entrez/efetch"

rule plot:
    input:
        "demo-results/test.fasta"
    output:
        report("plots/plot_A.svg", caption="report/plot_A.rst", category="Step1")
    conda:
        "envs/plot.yaml"
    script:
        "scripts/plot_sequence_distribution.py"