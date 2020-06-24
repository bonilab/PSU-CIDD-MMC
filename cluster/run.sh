#!/bin/bash

LIMIT=0
TREATMENT=

# 0.001 0.001 0.009
# 0.01 0.01 0.5
# 0.6  0.1  1.0
# 1.25 0.25 3.0

for i in 0.00925 0.0095 0.00975;
do
  sed 's/#BETA#/'"$i"'/g' mmc.yml > mmc-pr-treat-0.55-$i.yml
  sed 's/#BETA#/'"$i"'/g' template.job > 0.55-$i.pbs
  qsub 0.55-$i.pbs
done

