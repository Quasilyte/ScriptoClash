<?php

/*
* Author: Iskander Sharipov
*/

$timestamp = microtime();

// Массив слов.
$map[0] = explode("\n", file_get_contents('input/file1.txt'));
unset($map[0][count($map[0]) - 1]);

// Массив чисел.
$map[1] = explode("\n", file_get_contents('input/file2.txt'));
unset($map[1][count($map[1]) - 1]);

$spell = '';
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
  }
}


$elemCount = count($map[1]) / 2;
$vector1 = array_slice($map[1], 0, $elemCount);
$vector2 = array_slice($map[1], $elemCount, $elemCount);

// Конъюнкция и сумма массивов [0...34] & [35..69].
for($i = 0, $sum = 0; $i < $elemCount; ++$i) {
  $vector1[$i] &= (int)$vector2[$i];
  $sum += $vector1[$i];
}

$timestamp = microtime() - $timestamp;
echo "$timestamp\n";

?>
