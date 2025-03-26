import matplotlib.pyplot as plt

file = open("/home/eva/Документы/ITMO/2_course/MatStat/lab1/mobile_phones.csv")

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

def plots(data, title="Графики распределения"):

    fig, axes = plt.subplots(1, 3, figsize=(18, 6))
    fig.suptitle(title, fontsize=16)

    sorted_data = sorted(data)
    n = len(sorted_data)
    x_values = sorted_data
    y_values = [i / n for i in range(1, n + 1)]
    
    axes[0].step(x_values, y_values, where='post', label='ЭФР', color='red', linewidth=2.5)
    axes[0].set_xlabel('Значения', fontsize=12)
    axes[0].set_ylabel('F(x)', fontsize=12)
    axes[0].set_title('Эмпирическая функция распределения', fontsize=14)
    axes[0].legend(fontsize=10)
    axes[0].grid(True)

    axes[1].hist(data, bins=30, color='blue', edgecolor='black', linewidth=1.5)
    axes[1].set_xlabel('Значения', fontsize=12)
    axes[1].set_ylabel('Частота', fontsize=12)
    axes[1].set_title('Гистограмма', fontsize=14)
    axes[1].grid(True)

    axes[2].boxplot(data, vert=True, patch_artist=True, boxprops=dict(facecolor="lightblue"))
    axes[2].set_ylabel('Значения', fontsize=12)
    axes[2].set_title('Box-plot', fontsize=14)
    axes[2].grid(True)
    
    plt.tight_layout()
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
plots(batteryPowerList, "Графики для всей совокупности batteryPower")

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
plots(batteryPowerListWiFi, "Графики для batteryPower с Wi-Fi")

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
plots(batteryPowerListNoWifi, "Графики для batteryPower без Wi-Fi")
