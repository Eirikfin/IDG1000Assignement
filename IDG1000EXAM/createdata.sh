#!/bin/bash

# 1 remove first column(url-links)
# 2 replace spaces with "-"
# 3 remove first character from each line, save output to names.txt
echo "" > names.txt
awk '{ $1=""; print $0 }'  url-place.txt | sed 's/ /-/g' | sed 's/^.//' >> names.txt
#Create a .txt with just the urls:
echo "" > urls.txt
awk '{print $1}' url-place.txt >> urls.txt


#create a file with all data needed for the website, also deletes the first and last line to clean up the output.
paste urls.txt names.txt population.txt decimalcoord.txt | sed '1d;$d' > data.txt