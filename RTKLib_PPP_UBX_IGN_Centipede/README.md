# PPP solution using RTKLib

Rinex 3.05 must be converted to 3.04 (using ``convbin``)

## Ny Alesund

UBX receivers collecting raw ubx files, converted to RINEX using ``convbin`` and processed
with precise orbit SP3 files and clock correction CLK files (no effect). Both SP3 and CLK files
must be renamed ``.sp3`` and ``.clk``.

<img src="NYA0_noclock.png">
<img src="NYA0_withclock.png">

<img src="NYA1_noclock.png">
<img src="NYA1_withclock.png">

## ENSMM and Besancon Observatory

RINEX resulting from the UBlox receiver ENSMM reference station is stored online at https://renag.resif.fr/pub/centipede_30s/.
According to https://renag.resif.fr/pub/centipede_30s/info.csv: ENSMM Centipede reference station is named A48800FRA

Besancon Observatory IGN RGP station RINEX files are stored at //rgpdata.ign.fr/pub/data_v3/

<img src="ENSMM-Obs.png">

<img src="RTKLib_manual_tide.png">
