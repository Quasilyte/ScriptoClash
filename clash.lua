os.execute("date +%s%N > buf/ts1 2>&1")

local array = {}
array[1] = {}
array[2] = {}

local function readingData(fileName, num)
    local f = io.open(fileName, "r")

    i = 0
    for line in f:lines() do
        i = i + 1
        array[num][i] = line
    end

    f:close()
end

readingData("input/file1.txt", 1)

local min = string.len(array[1][1])
local max = min
for i = 2, #array[1] do
    local size = string.len(array[1][i])

    if size > max then
        max = size
    end

    if size < min then
        min = size
    end
end

local str = ""
local vowel = {'a', 'e', 'i', 'o', 'u'}
local cs = 0

for i = 1, #array[1] do
    cAscii = string.byte(array[1][i], 1)
    if cAscii >= 97 and cAscii <= 101 then
        str = str .. array[1][i] .. "_"

        for c in array[1][i]:gmatch"." do
            for j = 1, 5 do
                if c == vowel[j] then
                    cs = cs + 1
                end
            end
        end
    end
end

readingData("input/file2.txt", 2)
local cSlice = #array[2] / 2
local sumSlice = 0
for i = 1, cSlice do
    array[2][i] = (array[2][i] * array[2][i + cSlice])^0.5
    sumSlice = sumSlice + array[2][i]
end

local ack
function ack(M,N)
    if M == 0 then return N + 1 end
    if N == 0 then return ack(M-1,1) end
    return ack(M-1,ack(M, N-1))
end

local ackRez = ack(3, 3)

os.execute("date +%s%N > buf/ts2 2>&1")

local f1 = io.open("buf/ts1", "r")
local f2 = io.open("buf/ts2", "r")
ts = (f2:read("*n") - f1:read("*n")) / 100000.
f1:close()
f2:close()

--------------------------------------------

print("elapsed: " .. ts)
print("max length: " .. max)
print("min length: " .. min)
print("spell length: " .. string.len(str) .. " checksum: " .. cs)
print("sum: " .. sumSlice)
print("ackerman: " .. ackRez)