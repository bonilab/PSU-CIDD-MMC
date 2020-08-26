#!/bin/bash

# The number to limit the processes to
LIMIT=90

for adjustment in 0.2 0.3 0.4 0.5; do
  for i in `seq 0.01 0.01 1.25`; do
    # Get the current job count, note the overcount due to the delay.
    # Wait if there are currently too many jobs
    while [ `qstat -u rbz5100 | grep rbz5100 | wc -l` -gt $LIMIT ]
    do
      sleep 10s
    done

    sed 's/#BETA#/'"$i"'/g' mmc.yml > mmc-0.30-$i.yml
    sed 's/#BETA#/'"$i"'/g' template.job > 0.30-$i.pbs
    qsub 0.30-$i.pbs
  done
done