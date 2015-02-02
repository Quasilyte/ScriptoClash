-- local x = os.clock()

array = {}
array[1] = {}
array[2] = {}

function readingData(fileName, num)
    f1 = io.open(fileName, "r")

    i = 0
    for line in f1:lines() do
        i = i + 1
        array[num][i] = line
    end

    f1:close()
end

readingData("input/file1.txt", 1)
readingData("input/file2.txt", 2)

min = string.len(array[1][1])
max = min
for i = 2, #array[1] do
    size = string.len(array[1][i])

    if size > max then
        max = size
    end

    if size < min then
        min = size
    end
end

str = ""
for i = 1, #array[1] do
    if string.byte(array[1][i], 1) >= 97 and
        string.byte(array[1][i], 1) <= 101 then
        str = str .. array[1][i] .. "_"
    end
end

cSlice = #array[2] / 2
sumSlice = 0
for i = 1, cSlice do
    array[2][i] = (array[2][i] * array[2][i + cSlice])^0.5
    sumSlice = sumSlice + array[2][i]
end

-- print(string.format("elapsed time: %.6f\n", os.clock() - x))
