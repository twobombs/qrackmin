#!/bin/bash
# at a depth of up to $i scaling will be ramping up to 128

cd /pyqrack-examples/rcs

for ((i=4; i<=128; i++)); do
  for ((j=1; j<=i; j++)); do
    echo "Running i=$i, j=$j"
    python3 sycamore_2019_patch_quadrant_time.py "$i" "$j" 2>>errors_sycamore_2019_patch_quadrant_time.txt 1>>sycamore_2019_patch_quadrant_time_$(echo $i).txt
  done
done

# end run, do not stop container
tail -f /dev/null
