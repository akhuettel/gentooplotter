#!/usr/bin/python

from collections import Counter
import sys

freq = Counter()
total = 0

for l in sys.stdin.readlines():
    freq.update(l.strip().split())
    total+=1

print(total,)

arches=sys.argv[1:]

for arch in arches:
    print(freq['~'+arch]+freq[arch],)
    print(freq[arch],)

