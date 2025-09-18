a=""
# for i in S1C*.zip; do 
for i in S1A*.zip; do 
# for i in `ls *zip | sort -t_ -k 5.5`; do # check with sort -t_ -k 5.5 --debug  # reorder according to date but different polarizations cannot be used for InSAR => no interferogram between S1A and S1C
   echo $a $i
   if test -z "$a" 
      then echo "not good"
      else cat Makefile_phase.template | sed "s/NOM1/$a/g" | sed "s/NOM2/$i/g" > Makefile
           echo "Processing " $a $i
           make clean
           make
   fi 
   a=$i 
done

