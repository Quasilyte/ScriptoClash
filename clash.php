<?php

// Author: Quasilyte

exec('date +%s%N > buf/ts1 2>&1');

$map[0] = explode("\n", file_get_contents('input/file1.txt'));
unset($map[0][count($map[0]) - 1]);
$map[1] = explode("\n", file_get_contents('input/file2.txt'));
unset($map[1][count($map[1]) - 1]);

$spell = '';
$cs = 0;
$vowels = ['a' => 1, 'e' => 1, 'i' => 1, 'o' => 1, 'u' => 1];

$maxLen = 0;
$minLen = PHP_INT_MAX;

foreach($map[0] as $word) {
  if(($len = strlen($word)) > $maxLen) {
    $maxLen = $len;
  } elseif($len < $minLen) {
    $minLen = $len;
  }

  // Составляем заклинание.
  if(($ch = ord($word[0])) >= 97 && $ch <= 101) {
    $spell .= $word . '_';

    // Считаем гласные.
    for($i = 0, $len = strlen($word); $i < $len; ++$i) {
      if(isset($vowels[$word[$i]])) {
        $cs += 1;
      }
    }
  }
}

for($i = 0, $sum = 0; $i < 250; ++$i) {
  $sum += sqrt($map[1][$i] * $map[1][$i + 250]);
}

function acker($a, $b) {
  if(!$a) {
    return ++$b;
  } elseif($a && !$b) {
    return acker(--$a, 1);
  } elseif($a && $b) {
    return acker($a - 1, acker($a, --$b));
  }
}

$ackermann = acker(3, 3);

exec('date +%s%N > buf/ts2 2>&1');
$ts = (file_get_contents('buf/ts2') - file_get_contents('buf/ts1')) / 100000;

################################################################################

echo "elapsed: $ts\n";
echo "max length: $maxLen, min length: $minLen\n";
echo "spell length: " . strlen($spell) . ", checksum: $cs\n";
echo "sum: $sum\n";
echo "ackermann: $ackermann\n";
