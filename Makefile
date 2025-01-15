GPT=$(HOME)/snap/bin/gpt

all: target_final.dim

.DELETE_ON_ERROR:

FILENAME1=S1A_IW_SLC__1SDH_20171014T154536_20171014T154603_018811_01FC18_1292.zip

# Split
target_split.dim: $(FILENAME1)
	$(GPT) TOPSAR-Split -Ssource=$(FILENAME1) -PfirstBurstIndex=3 -PlastBurstIndex=4 -Psubswath=IW1 -t target_split

# Orbital Params
target_orb.dim: target_split.dim
	$(GPT) Apply-Orbit-File -Ssource=target_split.dim -t target_orb

# Deburst
target_deburst.dim: target_split.dim
# target_deburst.dim: target_orb.dim
	$(GPT) TOPSAR-Deburst -SsourceProduct=target_split.dim -t target_deburst.dim -c 2048M -q 2 

# Range Doppler Terrain: cf qgis for map projection
target_final.dim: target_deburst.dim
	$(GPT) Terrain-Correction -SsourceProduct=target_deburst.dim -PdemName="External DEM" -PexternalDEMFile="../DEM.tif" -PexternalDEMNoDataValue=0.0 -PmapProjection="EPSG:32632" -t target_final.dim

clean:
	rm -rf target*
