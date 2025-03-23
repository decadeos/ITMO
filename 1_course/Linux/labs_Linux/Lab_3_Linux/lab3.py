import sys
import csv
import random

CHUNK_MAX = 20
CHUNK_MIN = 10
LINE_NUM = 769

chunk_size = random.randrange(CHUNK_MIN, CHUNK_MAX)
slice_start = random.randrange(1, LINE_NUM-chunk_size)
slice_end = slice_start + chunk_size

out = [sys.stdout, sys.stderr]
with open('the-matrix-reloaded.csv', newline='') as csvfile:
    dialog_lines = list(csv.reader(csvfile))
    chosen_lines = dialog_lines[slice_start:slice_end]
    for line in chosen_lines:
        random_stream = random.choice(out)
        print(f'{line[0]}: {line[1]}', file=random_stream, flush=True)
