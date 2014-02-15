#!/usr/bin/perl

my @eapilist;

while (<>) {
  s/^EAPI //;
  s/: */ /;
  s/ ebuilds.*$//;
  my @columns=split;
  $eapilist{$columns[0]}=$columns[1];
};

for ($eapi=0; $eapi<=9; $eapi++) {
  if (! $eapilist{$eapi}) { $eapilist{$eapi}="0"; };
  print "$eapilist{$eapi} ";
}
print "\n";
