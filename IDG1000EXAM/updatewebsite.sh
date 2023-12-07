#!/bin/bash

# Input filenames
fulldata_file="fulldata.txt"
template_file="html-template.html"
output_file="output.html"

# Remove the existing output file
rm -f "$output_file"

# Loop through each line in fulldata.txt
while IFS=$'\t' read -r url place population lat lon temperature precipitation humidity
do
    # Read the HTML template and replace placeholder with data, then append to the output file
    sed "s|<!--REPLACE-->|<p><a href=\"$url\">City: $place</a> Population: $population Latitude: $lat Longitude: $lon Temperature: $temperature Precipitation: $precipitation Humidity: $humidity</p>|g" "$template_file" >> "$output_file"
done < "$fulldata_file"
