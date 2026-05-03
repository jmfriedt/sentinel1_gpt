## Scripts for automated processing of Sentinel-1 level-1 datasets

Using SNAP's command line tool ``gpt`` to automate processing of datasets
downloaded from https://dataspace.copernicus.eu/browser

<img src="2025-08-17-104851_2944x1080_scrot.png">

Automated downloading datasets from Alaska Satellite Facility (ASF) by using the
<a href="search_and_download.sh">script</a> in which the credentials (login and password)
must be replaced with valid entries.

Settings tuned for Brogger peninsula, Svalbard, to produce the datasets
presented in <br>
<a href="https://www.mdpi.com/2072-4292/15/7/1858">J.-M Friedt, E. Bernard, M. Griselin<br>Ground based oblique view photogrammetry and Sentinel1 spaceborne RADAR reflectivity snow melt processes assessment on an Arctic glacier<br>MDPI Remote Sensing vol. 15 n.7 1858-- (2023)</a>

The magnitude analysis is performed on all ``.zip`` files in the current directory by running 
``go_magnitude.sh`` which uses the settings of ``Makefile_magnitude.templateS1A`` set for 
``ascending`` (SDH -- horizontal polarization) and for ``descending`` (SDV -- vertical 
polarization). The resulting HH and VV images are most useful for dry/wet snow/ice detection
since there is hardly any polarization rotation of the backscattered signal (HV and VH).

The InSAR phase analysis is performed on all ``.zip`` pairs of a given satellite (A or C) by
running ``go_phase.sh`` which uses the settings of ``Makefile_phase.templateS1C``.

Tune parameters according to your needs:
* ``firstBurstIndex=6`` and ``lastBurstIndex=6`` of ``IW3`` in ``Makefile_magnitude.templateS1A`` 
for Sentinel1A (also valid for 1C)

<img src="2025-08-17-151035_1920x1080_scrot.png">

* ./DEM.tif for the DEM used for elevation correction: this DEM is the result
of merging (QGIS: Raster, Merge) <a href="https://data.npolar.no/dataset/dce53a47-c726-4845-85c3-a65b46fe2fea">NPI DEMs</a> 2009-13822, 2010-13828 and 2008-13660 and cropping to the 
area of interest,

Assumes the ``gdal-bin`` package is installed under the Debian/GNU Linux
to provide ``gdal-translate`` to convert the ``.img`` output to GeoTIFF ready
to be included in QGis. 

<img src="movie/kongsvegen.gif">

Movie of the Konsvegen and Kronebreen position as seen from Sentinel-1A from Feb. 2017 to Apr. 
2026.
