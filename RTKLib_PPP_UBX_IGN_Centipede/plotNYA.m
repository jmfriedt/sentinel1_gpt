load allNYA0_withclock.mat.gz
subplot(311);errorbar((solx-median(solx))*40000000/360*cosd(mean(soly)),stdx);ylabel('X (m)');ylim([-.3 .3])
hold on;plot((solx-median(solx))*40000000/360*cosd(mean(soly)),'r.')
title('with clock, position 0')
xlim([-5 230])
subplot(312);errorbar((soly-median(soly))*40000000/360,stdy);ylabel('Y (m)');ylim([-.3 .3])
hold on;plot((soly-median(soly))*40000000/360,'r.')
xlim([-5 230])
subplot(313);errorbar(solz-median(solz),stdz);ylabel('Z (m)');ylim([-.3 .3])
hold on;plot((solz-median(solz)),'r.')
xlim([-5 230])
xlabel('time (days)')

figure
load allNYA1_withclock.mat.gz
subplot(311);errorbar((solx-median(solx))*40000000/360*cosd(mean(soly)),stdx);ylabel('X (m)');ylim([-.3 .3])
hold on;plot((solx-median(solx))*40000000/360*cosd(mean(soly)),'r.')
xlim([-5 230])
title('with clock, position 1')
subplot(312);errorbar((soly-median(soly))*40000000/360,stdy);ylabel('Y (m)');ylim([-.3 .3])
hold on;plot((soly-median(soly))*40000000/360,'r.')
xlim([-5 230])
subplot(313);errorbar(solz-median(solz),stdz);ylabel('Z (m)');ylim([-.3 .3])
hold on;plot((solz-median(solz)),'r.')
xlim([-5 230])
xlabel('time (days)')

%%%%%%%%%%%%%%%%%% no clock file
figure
load allNYA0_noclock.mat.gz
subplot(311);errorbar((solx-median(solx))*40000000/360*cosd(mean(soly)),stdx);ylabel('X (m)');ylim([-.3 .3])
hold on;plot((solx-median(solx))*40000000/360*cosd(mean(soly)),'r.')
title('no clock, position 0')
xlim([-5 230])
subplot(312);errorbar((soly-median(soly))*40000000/360,stdy);ylabel('Y (m)');ylim([-.3 .3])
hold on;plot((soly-median(soly))*40000000/360,'r.')
xlim([-5 230])
subplot(313);errorbar(solz-median(solz),stdz);ylabel('Z (m)');ylim([-.3 .3])
hold on;plot((solz-median(solz)),'r.')
xlim([-5 230])
xlabel('time (days)')

figure
load allNYA1_noclock.mat.gz
subplot(311);errorbar((solx-median(solx))*40000000/360*cosd(mean(soly)),stdx);ylabel('X (m)');ylim([-.3 .3])
hold on;plot((solx-median(solx))*40000000/360*cosd(mean(soly)),'r.')
title('no clock, position 1')
xlim([-5 230])
subplot(312);errorbar((soly-median(soly))*40000000/360,stdy);ylabel('Y (m)');ylim([-.3 .3])
hold on;plot((soly-median(soly))*40000000/360,'r.')
xlim([-5 230])
subplot(313);errorbar(solz-median(solz),stdz);ylabel('Z (m)');ylim([-.3 .3])
hold on;plot((solz-median(solz)),'r.')
xlim([-5 230])
xlabel('time (days)')
