#!/bin/bash
# =Sentinel-1C& can be replaced with platform=Sentinel-1A,Sentinel-1C&
cmd="https://api.daac.asf.alaska.edu/services/search/param?platform=Sentinel-1C&intersectsWith=point%2811.6+78.8%29&processingLevel=SLC&beamMode=IW&output=csv&start=May+30,+2025&end=Aug+31,+2025&flightDirection=DESCENDING"
# keywords: https://docs.asf.alaska.edu/api/keywords/
# start and end dates
# flightDir=ASCENDING or DESCENDING
# intersectsWith: coorinates of point of interest

# cmd="https://api.daac.asf.alaska.edu/services/search/param?platform=Sentinel-1A,Sentinel-1C&intersectsWith=point%2811.6+78.8%29&processingLevel=SLC&beamMode=IW&output=csv&start=May+30,+2025"
cmd="https://api.daac.asf.alaska.edu/services/search/param?platform=Sentinel-1A&intersectsWith=point%2812.0+78.9%29&processingLevel=SLC&beamMode=IW&output=csv&start=Jan+01,+2017"
# https://docs.asf.alaska.edu/api/keywords/
laliste=$( ls asf.csv )
if [ -z "$laliste" ]; then 
  echo $cmd | xargs curl > asf.csv
  cat asf.csv | sort -n > tmp
  mv tmp asf.csv
fi
for k in `cat asf.csv  | cut -d, -f27 | tr \" \ `; do 
  ladate=$( echo $k | cut -c 57-64 )
  laliste=$( ls *${ladate}*tif* ${ladate}*${ladate}*dimdata )
  if [ -z "$laliste" ]; then 
      echo $ladate "afaire"
      laliste=$( ls *${ladate}*zip )
      if [ -z "$laliste" ]; then 
# replace XXXX with credentials
         wget --http-user=XXXX --http-password=XXXX $k
      fi
      for i in *SDV*zip; do 
        ladate=$( echo $i | cut -c 18-25 )
        laliste=$( ls *${ladate}*dim *${ladate}*tif *${ladate}*gz )
        if [ -z "$laliste" ]; then 
          echo $ladate "afaire SDV"
          make -f Makefile.SDV clean 
          FILENAME1=$i make -f Makefile.SDV 
        else 
           echo $ladate "done" ;
        fi
      done
      for i in *SDH*zip; do 
        ladate=$( echo $i | cut -c 18-25 )
        laliste=$( ls *${ladate}*dim *${ladate}*tif *${ladate}*gz )
        if [ -z "$laliste" ]; then 
          echo $ladate "afaire SDH"
          make -f Makefile.SDH clean 
          FILENAME1=$i make -f Makefile.SDH
        else 
          echo $ladate "done" ;
        fi
      done
    else 
   echo $ladate "done" ;
  fi
done
