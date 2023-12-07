#!/bin/bash

# Your existing script here

# Get the date for tomorrow in the format of year/month/day as a variable.
tomorrow=$(date -d "tomorrow" +"%Y-%m-%d")
#clear out weather_data for fresh input
echo "" > weather_data.txt
echo "" > lastcheck.txt
# Loop through each line in the data.txt file
while IFS=$'\t' read -r url city population lat lon; do
    # Extract latitude and longitude values
    lat_value=$(echo "$lat" | cut -d' ' -f2)
    lon_value=$(echo "$lon" | cut -d' ' -f2)

    # Fetch weather data for the current location
    weather_data=$(curl -A "NTNU student project eirihf@stud.ntnu.no" -s "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=$lat_value&lon=$lon_value")
#error if curl fails to get data
if [ $? -ne 0 ]; then
    echo "Error fetching data for $city" >> weather_data.txt
fi

    # Extract relevant information for tomorrow at 12:00 jq needs to be installed. Chooses the next day and the time 12:00. Extracts temperature (.data.instant.details.air_temperature), precipitaion for next 6 hours and humidity
    selected_data=$(echo "$weather_data" | jq -c --arg tomorrow "$tomorrow" '.properties.timeseries[] | select(.time | startswith($tomorrow) and contains("T12:00:00")) | { temp: .data.instant.details.air_temperature, precip: .data.next_6_hours.details.precipitation_amount, humidity: .data.instant.details.relative_humidity}')

if [ $? -ne 0 ]; then
    echo "Error fetching data for $city" >> weather_data.txt
fi
    # Append the result to a file with the city name
    echo "$selected_data"| sed 's/[a-z{}\"\,]//g' | sed 's/:/   /g'>> weather_data.txt
    
    date -u >> lastcheck.txt

done < data.txt
#combine the wheater with the rest of the data
sed -i '1d' weather_data.txt

paste weather_data.txt lastcheck.txt > weather_data2.txt

paste data.txt weather_data2.txt > fulldata.txt



