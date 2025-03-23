import matplotlib.pyplot as plt

file = open("mobile_phones.csv")

def calculateMean(data):
    return sum(data) / len(data)

def calculateVariance(data):
    mean = calculateMean(data)
    return sum((x - mean) ** 2 for x in data) / (len(data) - 1)

def calculateMedian(data):
    sortedData = sorted(data)
    n = len(sortedData)
    if n % 2 == 1:
        return sortedData[n // 2]
    else:
        return (sortedData[n // 2 - 1] + sortedData[n // 2]) / 2

def calculateQuantile(data, p):
    sortedData = sorted(data)
    n = len(sortedData)
    index = p * (n - 1)
    lowerIndex = int(index)
    fraction = index - lowerIndex
    if lowerIndex + 1 < n:
        return sortedData[lowerIndex] + fraction * (sortedData[lowerIndex + 1] - sortedData[lowerIndex])
    return sortedData[lowerIndex]

import matplotlib.pyplot as plt

def plotEmpiricalDistribution(data):
    sortedData = sorted(data)
    n = len(sortedData)
    
    xValues = sortedData
    yValues = [i / n for i in range(1, n + 1)]
    
    plt.figure(figsize=(8, 6))
    plt.step(xValues, yValues, where='post', label='ЭФР', color='red', linewidth=2.5)
    
    plt.xlabel('Значения', fontsize=14)
    plt.ylabel('F(x)', fontsize=14) 
    plt.title('Эмпирическая функция распределения', fontsize=16)
    plt.legend(fontsize=12)
    plt.grid(True)
    plt.xticks(fontsize=12)
    plt.yticks(fontsize=12) 
    plt.show()

def plotHistogram(data):
    plt.figure(figsize=(8, 6))
    plt.hist(data, bins=30, color='blue', edgecolor='black', linewidth=1.5)
    plt.xlabel('Значения', fontsize=14)
    plt.ylabel('Частота', fontsize=14)
    plt.title('Гистограмма', fontsize=16)
    plt.grid(True)
    plt.xticks(fontsize=12)
    plt.yticks(fontsize=12)
    plt.show()

counter = 0
data = list()

counterDualSim = 0
counterTreeG = 0
maxNCores = -100500
batteryPowerList = list()
batteryPowerListWiFi = list()
batteryPowerListNoWifi = list()

for str in file:
    counter += 1
    if counter != 1:
        row = (list(map(float, str.split(','))))
        data.append(row)

        # Question 1
        if row[3] == True:
            counterDualSim += 1
        # Question 2
        if row[-4] == True:
            counterTreeG += 1
        # Question 3
        if row[9] > maxNCores:
            maxNCores = row[9]
        # Question 4
        batteryPowerList.append(row[0])
        # Question 5
        batteryPowerListWiFi.append(row[0]) if row[-2] == True else None
        # Question 6
        batteryPowerListNoWifi.append(row[0]) if row[-2] == False else None


print(counterDualSim, " - столько телефонов поддерживают 2 сим-карты")  # Question 1
print(counterTreeG, " - столько телефонов имеют 3G") # Question 2
print(int(maxNCores), "- максимальное число ядер процессора") # Question 3

# Question 4 - расчет парамеров для всей совокупности batteryPower
batteryPowerSampleMean = calculateMean(batteryPowerList)
batteryPowerSampleVariance = calculateVariance(batteryPowerList)
sampleMedian = calculateMedian(batteryPowerList)
sampleQuantile = calculateQuantile(batteryPowerList, 2/5)

print("################## эти параметры для всей совокупности batteryPower ##################")
print(batteryPowerSampleMean, "- выборочное среднее")
print(batteryPowerSampleVariance, "- выборочная дисперсия")
print(sampleMedian, "- выборочная медиана")
print(sampleQuantile, "- выборочная квантиль порядка 2/5")
plotEmpiricalDistribution(batteryPowerList)
plotHistogram(batteryPowerList)


# Question 5 - расчет парамеров для batteryPower, поддерживащих Wi-Fi

wiFiBatteryMean = calculateMean(batteryPowerListWiFi)
wiFiBatteryVariance = calculateVariance(batteryPowerListWiFi)
wiFiBatteryMedian = calculateMedian(batteryPowerListWiFi)
wiFiBatteryQuantile = calculateQuantile(batteryPowerListWiFi, 2/5)

print("################## эти параметры для телефонов с Wi-Fi ##################")
print(wiFiBatteryMean, "- выборочное среднее")
print(wiFiBatteryVariance, "- выборочная дисперсия")
print(wiFiBatteryMedian, "- выборочная медиана")
print(wiFiBatteryQuantile, "- выборочная квантиль порядка 2/5")
plotEmpiricalDistribution(batteryPowerListWiFi)
plotHistogram(batteryPowerListWiFi)

# Question 6 - расчет парамеров для batteryPower, не поддерживащих Wi-Fi

noWifiBatteryMean = calculateMean(batteryPowerListNoWifi)
noWifiBatteryVariance = calculateVariance(batteryPowerListNoWifi)
noWifiBatteryMedian = calculateMedian(batteryPowerListNoWifi)
noWifiBatteryQuantile = calculateQuantile(batteryPowerListNoWifi, 2/5)

print("################## эти параметры для телефонов без Wi-Fi ##################")
print(noWifiBatteryMean, "- выборочное среднее")
print(noWifiBatteryVariance, "- выборочная дисперсия")
print(noWifiBatteryMedian, "- выборочная медиана")
print(noWifiBatteryQuantile, "- выборочная квантиль порядка 2/5")
plotEmpiricalDistribution(batteryPowerListNoWifi)
plotHistogram(batteryPowerListNoWifi)