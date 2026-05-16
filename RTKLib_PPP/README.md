## RTKLib PPP solution

Automated file fetching for Ny-Alesund area GNSS observations, precise
clock (CLK) and orbital parameters (SP3) and navigation data (.nav) online.

After running ``octave go.m`` to fetch and process files, execute from within
GNU Octave ``processall`` to load processed files and plot the resulting chart.

<img src="rebound_rtklib.png">

Assumes ``crx2rnx`` from https://terras.gsi.go.jp/ja/crx2rnx.html was compiled from
source and that RTKLib's ``rnx2rtkp`` from https://www.rtklib.com/ was 
compiled:
```
git clone https://github.com/tomojitakasu/RTKLIB/ RTKLIB_2.4.3
cd RTKLIB_2.4.3
git checkout rtklib_2.4.3
cd lib/iers/gcc
make
cd ../../../app/consapp/rnx2rtkp/gcc/
make
```

Notice: using the precise clock file will **not** work with the Demo5 version of
RTKLIB (tested with https://github.com/Papstors/RTKLIB)
