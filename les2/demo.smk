configfile: "config/demo-config.yaml"

rule all:
    input:
        config["output_directory"] + "aggragated_results.tsv"

rule count_lines:
    input:
        config["input_directory"] + "{sample}.txt"
    output:
        temp(config["output_directory"] + "{sample}.lines")
    params:
        config["line_count"]
    log:
        "logs/count_lines_{sample}.log"
    shell:
        "wc {params} {input} 1> {output} 2> {log}"

rule count_words:
    input:
        config["input_directory"] + "{sample}.txt"
    output:
        temp(config["output_directory"] + "{sample}.words")
    params:
        config["word_count"]
    message:
        "hallo dit is de regel count_words"
    log:
        "logs/count_words_{sample}.log"
    shell:
        "wc {params} {input} 1> {output} 2> {log}"

rule combine_counts:
    input:
        lines = config["output_directory"] + "{sample}.lines",
        words = config["output_directory"] + "{sample}.words"
    output:
        config["output_directory"] + "{sample}.summary"
    script:
        #"scripts/combine_counts.py"
        "scripts/combine_counts.R"

rule aggregate:
    input:
        expand(config["output_directory"] + "{sample}.summary", sample=config["samples"])
    output:
        config["output_directory"] + "aggragated_results.tsv"
    script:
        "scripts/aggregate.py"

