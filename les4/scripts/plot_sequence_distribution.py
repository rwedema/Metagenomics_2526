import matplotlib
matplotlib.use('Agg')

import matplotlib.pyplot as plt

sequence = ''
count_dict = {}

with open(snakemake.input[0], 'r') as f:
    next(f)
    for line in f:
       sequence += line.strip()

for letter in set(sequence):
    count_dict[letter] = sequence.count(letter) / len(sequence)

plt.bar(*zip(*count_dict.items()))
plt.savefig(snakemake.output[0])