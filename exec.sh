timestamp=$(($(date +%s%N)/1000000))
clisp clash.lisp
echo $(($(($(date +%s%N)/1000000)) - $timestamp))
