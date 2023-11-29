#!/bin/bash

#creating variables

#latidude
LAT=$(awk '{print $4}' data.txt)
#longitude
LON=$(awk '{print $6}' data.txt)

