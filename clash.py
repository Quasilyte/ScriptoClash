from math import sqrt
from os import system

system('date +%s%N > buf/ts1 2>&1')

array = ([], [])
vowel = ('a', 'e', 'i', 'o', 'u')

def readFile(fileName, num):
    f = open(fileName, 'r')

    i = 0
    for line in f:
        array[num].append(line)
        array[num][i] = array[num][i].rstrip('\n')

        if num == 1:
            array[num][i] = float(array[num][i])

        i += 1

    f.close()


readFile("input/file1.txt", 0)
readFile("input/file2.txt", 1)

maxElem = len(max(array[0], key=len))
minElem = len(min(array[0], key=len))

spell = ''
cs = 0
for i in range(0, len(array[0])):
    cAscii = ord(array[0][i][0])
    if cAscii >= 97 and cAscii <= 101:
        spell += array[0][i] + '_'

        for ch in array[0][i]:
            if ch in vowel:
                cs += 1


cSlice = int(len(array[1]) / 2)
sumSlice = 0.0

for i in range(0, cSlice):
    array[1][i] = sqrt(array[1][i] * array[1][i + cSlice])
    sumSlice += array[1][i]


def acker(a, b):
    if not a:
        # b += 1
        return b + 1
    elif not b and a:
        # a -= 1
        return acker(a - 1, 1)
    else:
        return acker(a - 1, acker(a, b - 1))

ackRez = acker(3, 3)

system('date +%s%N > buf/ts2 2>&1')

f1 = open('buf/ts1', 'r')
f2 = open('buf/ts2', 'r')
ts = (int(f2.read(19)) - int(f1.read(19))) / 100000.
f1.close()
f2.close()

##################################################

print("elapsed: {}".format(ts))
print("max length: {}".format(maxElem))
print("min length: {}".format(minElem))
print("spell length: {}, checksum: {}".format(len(spell), cs))
print("sum: {}".format(sumSlice))
print("ackerman: {}".format(ackRez))
