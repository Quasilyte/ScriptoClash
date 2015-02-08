# Author: Quasilyte

`date +%s%N > buf/ts1 2>&1`;

sub fslurp {
  local $/ = undef;
  open FILE, $_[0];

  my $rbuf = <FILE>;
  close FILE;
  return $rbuf;
}

my @map = (
  [split /\n/, fslurp('input/file1.txt')],
  [split /\n/, fslurp('input/file2.txt')]
);

my $spell = '', $cs = 0, $lmax = 0, $lmin = 255;
my $sum = 0;

for(@{$map[0]}) {
  my $len = length;

  if($len > $lmax) {
    $lmax = $len;
  } elsif($len < $lmin) {
    $lmin = $len;
  }

  if(ord() >= 97 && ord() <= 101) {
    $spell .= $_ . '_';
  }
}

$cs = ($spell =~ tr/aeiou//);

for(my $i = 0; $i < 250; ++$i) {
  $sum += sqrt @{$map[1]}[$i] * @{$map[1]}[$i + 250];
}

sub acker {
  if(!$_[0]) {
    return $_[1] + 1;
  } elsif($_[0] && !$_[1]) {
    return acker($_[0] - 1, 1);
  } elsif($_[0] && $_[1]) {
    return acker($_[0] - 1, acker($_[0], $_[1] - 1));
  }
}

my $ackermann = acker(3, 3);

`date +%s%N > buf/ts2 2>&1`;
my $ts = ((fslurp 'buf/ts2') - (fslurp 'buf/ts1')) / 100000;

################################################################################

print "elapsed: $ts\n";
print "max length: $lmax, min length: $lmin\n";
print "spell length: " . length $spell;
print ", checksum: $cs\n";
print "sum: $sum\n";
print "ackermann: $ackermann\n";
