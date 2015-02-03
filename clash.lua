print(string.format("%s\n", os.execute("date +%s%N > ts1.txt 2>&1")))
print(string.format("%s\n", os.execute("date +%s%N > ts2.txt 2>&1")))
-- comd >comd.txt 2>&1
