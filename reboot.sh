#!/bin/bash

urlRouter=http://192.168.0.1
loginUsername='admin'

regularExpresion='(?<=action=).*(?=method)'

echo "[+] Login Screen"
loginUrl=$(curl -s $urlRouter)

loginSubmit=$(echo $loginUrl | grep -o -P $regularExpresion)
echo $loginSubmit

echo "[+] Authenticating"

curl -d "loginUsername="$loginUsername"&loginPassword="$loginUsername $urlRouter$loginSubmit

echo "[+] Accessing the configuration"
configUrl=$(curl -s $urlRouter"/RgConfig.asp")
configSubmit=$(echo $configUrl | grep -o -P '(?<=action=).*(?=method)')
echo $configSubmit

echo "[+] Rebooting"
curl -d "ResetReq=1" $urlRouter$configSubmit

echo "Done"