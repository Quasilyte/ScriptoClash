system('date +%s%N > buf/ts1 2>&1')

array = Array.new(2) { |i| i = Array.new }

array[0] = IO.readlines("input/file1.txt")
array[1] = IO.readlines("input/file2.txt")

minWord = array[0].min { |a, b| a.size <=> b.size }.length - 1
maxWord = array[0].max { |a, b| a.size <=> b.size }.length - 1

mystr = ""
cs = 0
array[0].each do |i|
    firstCh = i[0].ord

    if firstCh >= 97 and firstCh <= 101 then
        mystr = "#{mystr}#{i.rstrip}_"

        cs += i.scan(/a|i|e|u|o/).length
    end
end

slice = array[1].length / 2
sumSlice = 0.0
rez = []
(0...slice).each do |i|
    rez[i] = Math.sqrt(array[1][i].to_i * array[1][i + slice].to_i)
    sumSlice += rez[i]
end

def ackermann(m, n)
  return n + 1 if m == 0
  return ackermann(m - 1, 1) if m > 0 && n == 0
  return ackermann(m - 1, ackermann(m, n - 1))
end

acker = ackermann(3, 3)

system('date +%s%N > buf/ts2 2>&1')

f1 = IO.readlines("buf/ts1")
f2 = IO.readlines("buf/ts2")
ts = (f2[0].to_i - f1[0].to_i) / 100000.0

############################

puts "elapsed: #{ts}"
puts "max length: #{maxWord}"
puts "min length: #{minWord}"
puts "spell length: #{mystr.length} checksum: #{cs}"
puts "sum: #{sumSlice}"
puts "ackermann: #{acker}"