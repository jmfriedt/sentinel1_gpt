load all.mat
% X
subplot(311)
k=find(solx==0);
solx(k)=NaN;
pkg load nan
solx=solx*40000000/360*cosd(mean(soly));
errorbar(solx-mean(solx),stdx)
ylim([-0.1 0.1])
xlim([0 200])
ylabel('X (m)')
k=find(isnan(solx)==0);
a=polyfit([1:length(solx(k))],solx(k)-mean(solx(k)),1)
hold on
plot([1:length(solx)],polyval(a,[1:length(solx)]),'r','linewidth',2)

% Y
subplot(312)
soly=soly*40000000/360;
k=find(soly==0);
soly(k)=NaN;
errorbar(soly-mean(soly),stdy)
ylabel('Y (m)')
xlim([0 200])
ylim([-0.1 0.1])
k=find(isnan(soly)==0);
a=polyfit([1:length(soly(k))],soly(k)-mean(soly(k)),1)
hold on
plot([1:length(soly)],polyval(a,[1:length(soly)]),'r','linewidth',2)
subplot(313)
k=find(solz==0);
solz(k)=NaN;
errorbar(solz-mean(solz),stdz)
xlim([0 200])
ylim([-0.1 0.1])
ylabel('Z (m)')
xlabel('time (5j/sample)')
N=8
zc=conv(solz,ones(N,1)/N);zc=zc(N:end-N);
hold on
plot([N/2:length(zc)+N/2-1],zc-median(zc),'linewidth',3)
