for i in `ls *S1A*zip`; do
  nom=`echo $i | cut -c 18-25`
  make clean
  cat Makefile_magnitude.templateS1A | sed "s/XXX/$i/g" > Makefile
  make
  gdal_translate -of GTiff ./target_final.data/Int*HV*.img ${nom}_final_intensityHV.tif
  gdal_translate -of GTiff ./target_final.data/Int*VH*.img ${nom}_final_intensityVH.tif
  gdal_translate -of GTiff ./target_final.data/Int*HH*.img ${nom}_final_intensityHH.tif
  gdal_translate -of GTiff ./target_final.data/Int*VV*.img ${nom}_final_intensityVV.tif
  octave go_magnitude.m ${nom}_final_intensityVV.tif
done
