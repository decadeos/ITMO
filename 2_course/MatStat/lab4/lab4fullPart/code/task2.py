
from scipy.stats import chisquare
from scipy import stats

f = open('exams_dataset.csv')

resultMath = [0] * 101
resultWrite = [0] * 101

continueCount = 0

for line in f:

    continueCount += 1
    if continueCount == 1:
        continue

    items = line.strip().replace('"', '').split(',')

    resultMath[int(items[-3])] += 1
    resultWrite[int(items[-1])] += 1

# Тест хи-квадратик ляляля жужужу
obs = [x for x in resultMath if x > 0]
exp = [sum(obs)/len(obs)] * len(obs)

_, p = chisquare(obs, exp)
print("Неравномерное" if p < 0.05 else "Равномерное")

# Тест когломорова-Смирнова
obs = [x for x in resultWrite if x > 0]
exp = [sum(obs)/len(obs)] * len(obs)

ks_stat, ks_p = stats.kstest(obs, 'uniform', args=(min(obs), max(obs) - min(obs)))
print("Неравномерное" if ks_p < 0.05 else "Равномерное")