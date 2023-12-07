#!/bin/bash

current_time=$(date -u)
api_url='https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=60.79&lon=10.69'

curl -A "NTNU student project eirihf@stud.ntnu.no" -i -H "If-Modified-Since: $current_time" -s "$api_url"
