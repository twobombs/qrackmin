#!/bin/bash
# example of qrack as a servive
# RNG generator based on QFT output 
# 

./qrack_Ubuntu_22.04_LTS_benchmarks --optimal-cpu --binary-output --measure-shots=1 -m=16 --samples=999999999 --single --measure-output /tmp/test_qft_cosmology2.txt test_qft_cosmology &

tail -f /tmp/test_qft_cosmology2.txt |  tr -d '\n'
