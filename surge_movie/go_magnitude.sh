for i in `ls -d *S1*zip.data`; do
  echo $i
  nom=`echo $i | cut -c 18-25`
  laliste=$( ls ${nom}*tif ${nom}*tif.gz )
  if [ -z "$laliste" ]; then 
    gdal_translate -projwin_srs EPSG:32633 -projwin 450000 8763600 490000 8717000 -of GTiff ${i}/Int*HV*.img ${nom}_final_intensityHV.tif
    gdal_translate -projwin_srs EPSG:32633 -projwin 450000 8763600 490000 8717000 -of GTiff ${i}/Int*VH*.img ${nom}_final_intensityVH.tif
    gdal_translate -projwin_srs EPSG:32633 -projwin 450000 8763600 490000 8717000 -of GTiff ${i}/Int*HH*.img ${nom}_final_intensityHH.tif
    gdal_translate -projwin_srs EPSG:32633 -projwin 450000 8763600 490000 8717000 -of GTiff ${i}/Int*VV*.img ${nom}_final_intensityVV.tif
  else 
    echo $nom $laliste "done" ;
    rm -rf S1A*${nom}*.zip
    rm -rf S1A*${nom}*.zip.data
    rm -rf S1A*${nom}*.zip.dim
  fi
done
gzip 2*tif
