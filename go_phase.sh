a=""
for i in S1C*.zip; do 
# for i in S1B*.zip; do 
   if test -z "$a" 
      then echo "not good"
      else cat Makefile_phase.template | sed "s/NOM1/$a/g" | sed "s/NOM2/$i/g" > Makefile  
           echo "Processing " $a $i
           make clean
           make
   fi 
   a=$i 
done

