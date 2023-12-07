#!/bin/bash

# Get the date for tomorrow in the format of year/month/day as a variable.
tomorrow=$(date -d "tomorrow" +"%Y-%m-%d")



curl -A "NTNU student project eirihf@stud.ntnu.no" -I -X GET --header 'Accept: application/json' 'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=60.795&lon=10.691' | awk -F": " '/^expires:/ {gsub(/,/, ""); print substr($2, 6)}' | cut -d' ' -f1- > lol.txt

# Variable to Fetch weather data from the API and identifying myself to the met. 
weather_data=$(curl -A "NTNU student project eirihf@stud.ntnu.no" -s 'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=59.2172&lon=6.34083')


# Extract relevant information for tomorrow at 12:00 jq needs to be installed. Chooses the next day and the time 12:00. Extracts temperature (.data.instant.details.air_temperature), precipitaion for next 6 hours and humidity
selected_data=$(echo "$weather_data" | jq -c --arg tomorrow "$tomorrow" '.properties.timeseries[] | select(.time | startswith($tomorrow) and contains("T12:00:00")) | { temp: .data.instant.details.air_temperature, precip: .data.next_6_hours.details.precipitation_amount, humidity: .data.instant.details.relative_humidity}')

# Append the result to a file
echo "$selected_data" date | sed 's/[a-z{}\"\,]//g' | sed 's/:/   /g' > test.txt
date +"%Y-%m-%d" > lastcheck.txt
paste test.txt lastcheck.txt > test2.txt 


#loop for fetching data for each municipality save in 
