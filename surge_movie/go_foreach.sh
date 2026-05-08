#!/bin/bash
for i in *SDV*zip; do 
   ladate=$( echo $i | cut -c 18-25 )
   laliste=$( ls *${ladate}*dim *${ladate}*tif *${ladate}*gz )
   if [ -z "$laliste" ]; then 
       echo $ladate "afaire"
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
       echo $ladate "afaire"
       make -f Makefile.SDH clean 
       FILENAME1=$i make -f Makefile.SDH
   else 
       echo $ladate "done" ;
  fi
done
