import os
import random

relax_period = random.choice(range(10, 20))
repetition_period = random.choice(range(30,60))

arr = os.listdir('./images')
icon = random.choice(arr)
print(f'Relax time: {relax_period} minutes')
print(f'Repetition period: {repetition_period} seconds')
print(f'Icon name: {icon}')
