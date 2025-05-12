from scipy.stats import f
fl = open('exams_dataset.csv')

countA = []
countB = []
countC = []
countD = []
countE = [] 
continueCount = 0

for line in fl:

    continueCount += 1
    if continueCount == 1:
        continue

    items = line.strip().replace('"', '').split(',')

    etnic = items[1]
    points = sum(map(int, items[-3:])) 

    if etnic[-1] == 'A':
        countA.append(points)
    elif etnic[-1] == 'B':
        countB.append(points)
    elif etnic[-1] == 'C':
        countC.append(points)
    elif etnic[-1] == 'D':
        countD.append(points)
    elif etnic[-1] == 'E':
        countE.append(points)


allScores = countA + countB + countC + countD + countE
mu = sum(allScores) / len(allScores)


groupMeans = [
    sum(countA)/len(countA), 
    sum(countB)/len(countB), 
    sum(countC)/len(countC), 
    sum(countD)/len(countD), 
    sum(countE)/len(countE)  
]

groupSizes = [len(countA), len(countB), len(countC), len(countD), len(countE)]


SSB = sum(
    n * (groupMean - mu) ** 2 
    for n, groupMean in zip(groupSizes, groupMeans)
)


groups = [countA, countB, countC, countD, countE]
SSW = 0.0
for group, mean in zip(groups, groupMeans):
    for score in group:
        SSW += (score - mean) ** 2


N = sum(len(group) for group in groups)  
k = len(groups)                           

dfTotal = N - 1
dfBetween = k - 1
dfWithin = N - k


MSB = SSB / dfBetween 
MSW = SSW / dfWithin
F = MSB / MSW 

alpha = 0.05
F_crit = f.ppf(1 - alpha, dfBetween, dfWithin)

# если F > F_crit, то зависит. думойте.