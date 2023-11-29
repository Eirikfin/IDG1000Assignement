#curl -A "student project eirihf@stud.ntnu.no" -s 'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=63.4297&lon=10.3933' | json_pp >> test.txt
#curl -A "student project eirihf@stud.ntnu.no" -s 'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=63.4297&lon=10.3933' | jq -c '.properties.timeseries[] | select(.time | contains("T12:00:00")) | {temperature: .data.instant.details.air_temperature, precipitation: .data.next_1_hours.details.precipitation, humidity: .data.instant.details.relative_humidity}' >> weather_data.json
#!/bin/bash

# Get the date for tomorrow in the format expected by the API
tomorrow=$(date -d "tomorrow" +"%Y-%m-%d")

# Fetch weather data from the API
weather_data=$(curl -A "student project eirihf@stud.ntnu.no" -s 'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=59.2172&lon=6.34083')

# Extract relevant information for tomorrow at 12:00
selected_data=$(echo "$weather_data" | jq -c --arg tomorrow "$tomorrow" '.properties.timeseries[] | select(.time | startswith($tomorrow) and contains("T12:00:00")) | {temperature: .data.instant.details.air_temperature, precipitation: .data.next_1_hours.details.precipitation, humidity: .data.instant.details.relative_humidity}')

# Append the result to a file
echo "$selected_data" > weather_data.json
