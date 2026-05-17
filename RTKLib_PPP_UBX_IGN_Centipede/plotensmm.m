load allObs_no_tide_correction.mat.gz
ko=find(solx>0);
solxObs=solx(:,ko);
solyObs=soly(:,ko);
solzObs=solz(:,ko);
stdxObs=stdx(:,ko);
stdyObs=stdy(:,ko);
stdzObs=stdz(:,ko);

load allObs_withclock_withtide.mat.gz
kot=find(solx>0);
solxObstide=solx(:,kot);
solyObstide=soly(:,kot);
solzObstide=solz(:,kot);
stdxObstide=stdx(:,kot);
stdyObstide=stdy(:,kot);
stdzObstide=stdz(:,kot);

load all_ensmm2024-2025.mat.gz
solx1=solx;
soly1=soly;
solz1=solz;
stdx1=stdx;
stdy1=stdy;
stdz1=stdz;
load all_ensmm2026.mat.gz
solx=[solx1  solx];
soly=[soly1  soly];
solz=[solz1  solz];
stdx=[stdx1  stdx];
stdy=[stdy1  stdy];
stdz=[stdz1  stdz];
k=find(solx>0);
solx=solx(k);
soly=soly(k);
solz=solz(k);
stdx=stdx(k);
stdy=stdy(k);
stdz=stdz(k);
subplot(311);
errorbar(k,(solx-median(solx))*40000000/360*cosd(median(soly)),stdx);
hold on;plot(k,(solx-median(solx))*40000000/360*cosd(median(soly)),'r.');
plot(ko,(solxObs-median(solxObs))*40000000/360*cosd(median(solyObs)),'g.');
plot(kot,(solxObstide-median(solxObstide))*40000000/360*cosd(median(solyObstide)),'c.');
ylim([-0.15 0.15])
ylabel('dx (m)');xlim([-5 900])
line([365 365],[-0.15 0.1]); line(2*[365 365],[-0.15 0.1])
subplot(312);errorbar(k,(soly-median(soly))*40000000/360,stdy);
hold on;plot(k,(soly-median(soly))*40000000/360,'r.');
plot(ko,(solyObs-median(solyObs))*40000000/360,'g.');
plot(kot,(solyObstide-median(solyObstide))*40000000/360,'c.');
ylim([-0.15 0.15])
ylabel('dy (m)');xlim([-5 900])
line([365 365],[-0.15 0.1]); line(2*[365 365],[-0.15 0.1])
subplot(313);errorbar(k,(solz-median(solz)),stdz);hold on;plot(k,(solz-median(solz)),'r.');ylim([-0.15 0.15])
plot(ko,(solzObs-median(solzObs)),'g.');
plot(kot,(solzObstide-median(solzObstide)),'c.');ylim([-0.15 0.15])
ylabel('dz (m)');xlim([-5 900])
line([365 365],[-0.15 0.1]); line(2*[365 365],[-0.15 0.1])
xlabel('jours (1/1/2024--1/05/2026)')
legend('ENMM errorbar','ENSMM','Obs','Obs with tide correction')
