#!/bin/bash

# cd /pyqrack-examples/ising

for ((i=4; i<=56; i++)); do
  # Array to store PIDs of background jobs for the current 'i'
  pids=()

  echo "--- Starting batch for i=$i ---"
  for ((j=4; j<=i; j++)); do
    echo "Running i=$i, j=$j"
    # Execute python script in the background
    python3 ising_qbdd_fixes.py "$j" "$i" 2>>errors_ising_qbdd_fixes_$(echo $i)_$(echo $j).txt 1>>ising_qbdd_fixes_$(echo $i)_$(echo $j).txt &
    # Store the PID of the last backgrounded process
    pids+=($!)

  done
  
  echo "--- Waiting for all python scripts launched for i=$i to complete... ---"
  # The 'wait' command waits for the specified PIDs to finish.
  # Using "${pids[@]}" ensures all PIDs in the array are passed correctly.
  wait "${pids[@]}"
  echo "--- All scripts for i=$i completed. Proceeding to next i. ---"

done

echo "--- All batches finished ---"

# end run, do not stop container
tail -f /dev/null
