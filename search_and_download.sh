#!/bin/bash
# =Sentinel-1C& can be replaced with platform=Sentinel-1A,Sentinel-1C&
cmd="https://api.daac.asf.alaska.edu/services/search/param?platform=Sentinel-1C&intersectsWith=point%2811.6+78.8%29&processingLevel=SLC&beamMode=IW&output=csv&start=May+30,+2025&end=Aug+31,+2025&flightDirection=DESCENDING"
# keywords: https://docs.asf.alaska.edu/api/keywords/
# start and end dates
# flightDir=ASCENDING or DESCENDING
# intersectsWith: coorinates of point of interest
echo $cmd | xargs curl > asf.csv
for k in `cat asf.csv  | cut -d, -f27 | tr \" \ `; do 
  echo $k;
# replace XXXX with credentials
  wget --http-user=XXXX --http-password=XXXX $k
done
