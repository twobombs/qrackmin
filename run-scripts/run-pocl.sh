#!/bin/bash
# start pocld advertising on port 1234

cd /pocl && pocld -a localhost -p 1234 &

tail -f /dev/null
