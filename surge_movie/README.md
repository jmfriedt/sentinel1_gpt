# Sentinel1 image collection, conversion and movie generation

The DEM needed for processing the S1A datasets is merged from 2009-13822, 2010-13828 and 2008-13660
found at https://data.npolar.no/dataset/dce53a47-c726-4845-85c3-a65b46fe2fea using QGIS Raster Merge.
The DEM is then clipped to the border.shp limits.


1. ``search.sh`` to fetch the list of Sentinel1 pictures on Alaska Satellite Facility (ASF) and process to generate the images
2. ``go_foreach.sh`` to restart processing in case ``search.sh`` stopped or failed
3. ``go_magnitude.sh`` to convert the Sentinel1 processing output to GeoTIFF
4. to convert GeoTIFF to PNG
```
for i in 2*HH.tif.gz;do zcat $i > t.tif; nom=`echo $i | sed 's/tif.gz$/png/g' | sed 's/\.\.\///g'`; echo $i $nom; gdal_translate -of PNG -ot Uint16 -scale 0 30000. 0 65535 t.tif $nom; done
```
5. to assemble PNG to a movie
```
ffmpeg -f image2 -r 25 -pattern_type glob -i '*.png' -vcodec libx264 -crf 22 video.mp4
```
6. to shrink the PNG size in order to generate a more modest movie
```
for i in 2*HH.png;do nom=`echo $i | sed 's/\.png/small\.png/g'` ; d=`echo $i | cut -c 1-8`;echo $i $nom; convert -crop 1450x1100+1200+1000 -fill red -stroke red -pointsize 70 -annotate +1210+2065 $d $i $nom; done
```
