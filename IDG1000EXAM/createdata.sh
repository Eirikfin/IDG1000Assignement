#!/bin/bash

# 1 remove first column(url-links)
# 2 replace spacees with "-"
# 3 remove first character from each line, save output to names.txt
echo "" > names.txt
awk '{ $1=""; print $0 }'  url-place.txt | sed 's/ /-/g' | sed 's/^.//' >> names.txt


#create a file with all data needed for the website, also deletes the first and last line to clean up the output.
paste names.txt population.txt decimalcoord.txt | sed '1d;$d' > data.txt