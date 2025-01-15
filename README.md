## Scripts for automated processing of Sentinel-1 level-1 datasets

Using SNAP's command line tool ``gpt`` to automate processing of datasets
downloaded from https://dataspace.copernicus.eu/browser

Settings tuned for Brogger peninsula, Svalbard, to produce the datasets
presented in 
```J.-M Friedt, E. Bernard, M. Griselin
Ground based oblique view photogrammetry and Sentinel1 spaceborne RADAR reflectivity snow melt processes assessment on an Arctic glacier
MDPI Remote Sensing vol. 15 n.7 1858-- (2023)
```

Tune parameters according to your needs:
* firstBurstIndex=3 lastBurstIndex=4 in ``Makefile.templateS1A``
* ../DEM.tif for the DEM used for elevation correction

Assumes the ``gdal-bin`` package is installed under the Debian/GNU Linux
to provide ``gdal-translate`` to convert the ``.img`` output to GeoTIFF ready
to be included in QGis. 
