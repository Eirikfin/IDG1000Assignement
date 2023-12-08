#!/bin/bash

curl -A "NTNU student project eirihf@stud.ntnu.no" -I -X GET --header 'Accept: application/json' 'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=59.912&lon=10.746' | awk -F": " '/^expires:/ {gsub(/,/, ""); print substr($2, 6)}' | cut -d' ' -f1- > expire.txt