#!/bin/bash

#update the weather before refreshing the webpage
#bash getwheater.sh
# Loop to place the data into rightful place, and creates the paragrapghs for the webpage
echo "" > webpage.txt

while read url place population lat latvalue lon lonvalue temp prec humidity weekday date month time; do
    printf "<p><a href=\"%s\">\t%s</a> has a population of:\t%s\t Coordinates: lat: %s\t lon: %s\t The weather for tomorrow is Temperature: %s°C\t Precipation: %s mm\t Moisture: %s%% Weather last updated: %s %s %s %s</p>\n" "$url" "$place" "$population" "$latvalue" "$lonvalue" "$temp" "$prec" "$humidity" "$weekday" "$date"  "$month" "$time">> webpage.txt
done < fulldata.txt
#todo delete first line of webpage.txt
webdata=$(cat webpage.txt)
awk -v replace="$webdata" '{gsub(/<!--REPLACE-->/, replace)}1' html-template.html > index.html

#todo move the index file to desired directory and update apache