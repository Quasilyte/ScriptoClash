<?php

// Author: Quasilyte

// $timestamp = microtime();

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

$bound = count($map[1]) / 2;
// sqrt ( [0...34] + [35..69] ).
for($i = 0, $j = 35, $sum = 0; $i < $bound; ++$i, ++$j) {
  $map[1][$i] = sqrt($map[1][$i] * $map[1][$j]);
  $sum += $map[1][$i];
}

// $timestamp = microtime() - $timestamp;
// echo "$timestamp\n";
