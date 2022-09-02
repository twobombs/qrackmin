# qrackmin
minimum Qrack@docker 

docker run --gpus all --device=/dev/dri:/dev/dri --mount type=bind,source=/var/log/qrack,target=/var/log/qrack -d twobombs/qrackmin

then: docker exec -ti [containerID] bash

Created for minimalistic verification purposes
All credits go to Dan Strano for creating Qrack

https://github.com/unitaryfund/qrack
