from tests import *

f = open('exams_dataset.csv')

maleCount = femaleCount = 0
countA = countB = countC = countD = countE = 0

for line in f:
    items = line.strip().replace('"', '').split(',')

    gender = items[0]
    etnic = items[1]

    if gender == 'male':
        maleCount += 1
    elif gender == 'female':
        femaleCount += 1
    
    if etnic[-1] == 'A':
        countA += 1
    elif etnic[-1] == 'B':
        countB += 1
    elif etnic[-1] == 'C':
        countC += 1
    elif etnic[-1] == 'D':
        countD += 1
    elif etnic[-1] == 'E':
        countE += 1

genderArray = list()
etnicArray = list()

genderArray += [maleCount, femaleCount]
etnicArray += [countA, countB,  countC,  countD, countE]

result = hiQuad(genderArray)
print(result, genderArray)

result = kolmogorovSmirnov(etnicArray)
print(result, etnicArray)
