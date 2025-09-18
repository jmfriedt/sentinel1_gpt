clear
close all
pkg load mapping
format long

% ROI
xstart=432000
xstop=438000
ystart=8754000
ystop=8766000

xNYA=433161;
yNYA=8762832;

xCOR=437754;
yCOR=8761014;

xNYAb=433974;
yNYAb=8763726;
  
dx=2;  % window size
threshold=0.1; % eliminate all measurements below max(intensity)*threshold

phnya_cor=[];
phnya_nya=[];
dis=1

d=dir('final*intensity*tif');
for l=1:length(d)
  d(l).name
  x=rasterread(d(l).name);
  if (l==1)
    x.bbox
  end
  xpos=linspace(x.bbox(1,1),x.bbox(2,1),size(x.data)(2)); % larger
  ypos=linspace(x.bbox(1,2),x.bbox(2,2),size(x.data)(1)); % smaller
  xk=find((xpos>=xstart)&(xpos<=xstop));
  yk=find((ypos>=ystart)&(ypos<=ystop));
  xpos=xpos(xk);
  ypos=ypos(yk);
  intens=x.data(yk,xk);
  x=rasterread(strrep(d(l).name,'intensity','phase'));
  % x=rasterread(strrep(d(l).name,'intensity','filtered'));
  phas=x.data(yk,xk);
  x=rasterread(strrep(d(l).name,'intensity','coh'));
  coh=x.data(yk,xk);
  if (dis==1)
    figure
    hold on
    subplot(224)
%    imagesc(xpos,ypos,coh)
    imagesc(xpos,ypos,10*log10(intens+1))
    axis xy;
  end

% Ny Alesund airport FFI corer reflector
  x=find(xpos>=xNYA);x=x(1);
  y=find(ypos>=yNYA);y=y(1);
  if (dis==1)
    hold on
    line(xpos([x-dx x-dx]),ypos([y-dx y+dx]),'color',[1 0 0]); line(xpos([x+dx x+dx]),ypos([y-dx y+dx]),'color',[1 0 0]); line(xpos([x-dx x+dx]),ypos([y-dx y-dx]),'color',[1 0 0]); line(xpos([x-dx x+dx]),ypos([y+dx y+dx]),'color',[1 0 0]);
  end
  phtmp=phas(y-dx:y+dx,x-dx:x+dx);cohtmp=coh(y-dx:y+dx,x-dx:x+dx);intmp=intens(y-dx:y+dx,x-dx:x+dx);
  intmp(cohtmp<0.8)=0;
  intmp(intmp<max(max(intmp*threshold)))=0;
  phnya(l)=sum(sum(phtmp.*intmp))./sum(sum(intmp));
  % phnya(l)=sum(sum(phtmp))./sum(sum(ones(dx,dx)));
  if (dis==1)
     subplot(221)
     % imagesc(xpos(x-dx:x+dx),ypos(y-dx:y+dx),intmp);
     imagesc(xpos(x-dx:x+dx),ypos(y-dx:y+dx),cohtmp);colorbar
  end

% Corbel polish corner reflector
  x=find(xpos>=xCOR);x=x(1);
  y=find(ypos>=yCOR);y=y(1);
  % phcorbel=phas(y,x);
  phtmp=phas(y-dx:y+dx,x-dx:x+dx);cohtmp=coh(y-dx:y+dx,x-dx:x+dx);intmp=intens(y-dx:y+dx,x-dx:x+dx);
  intmp(cohtmp<0.8)=0;
  intmp(intmp<max(max(intmp*threshold)))=0;
  phcor(l)=sum(sum(phtmp.*intmp))./sum(sum(intmp));
  % phcor(l)=sum(sum(phtmp))./sum(sum(ones(dx,dx)));
  if (dis==1)
     subplot(224)
     line(xpos([x-dx x-dx]),ypos([y-dx y+dx]),'color',[1 0 0]); line(xpos([x+dx x+dx]),ypos([y-dx y+dx]),'color',[1 0 0]); line(xpos([x-dx x+dx]),ypos([y-dx y-dx]),'color',[1 0 0]); line(xpos([x-dx x+dx]),ypos([y+dx y+dx]),'color',[1 0 0]);
     subplot(222)
     % imagesc(xpos(x-dx:x+dx),ypos(y-dx:y+dx),intmp);
     imagesc(xpos(x-dx:x+dx),ypos(y-dx:y+dx),cohtmp);colorbar
     hold on
  end
  x=find(xpos>=xNYAb);x=x(1);
  y=find(ypos>=yNYAb);y=y(1);
  if (dis==1)
    subplot(224)
    hold on
    line(xpos([x-dx x-dx]),ypos([y-dx y+dx]),'color',[1 0 0]); line(xpos([x+dx x+dx]),ypos([y-dx y+dx]),'color',[1 0 0]); line(xpos([x-dx x+dx]),ypos([y-dx y-dx]),'color',[1 0 0]); line(xpos([x-dx x+dx]),ypos([y+dx y+dx]),'color',[1 0 0]);
  end
  % phnya2=phas(y,x);
  phtmp=phas(y-dx:y+dx,x-dx:x+dx);cohtmp=coh(y-dx:y+dx,x-dx:x+dx);intmp=intens(y-dx:y+dx,x-dx:x+dx);
  intmp(cohtmp<0.8)=0;
  intmp(intmp<max(max(intmp*threshold)))=0;
  phnya2(l)=sum(sum(phtmp.*intmp))./sum(sum(intmp));
  % phnya2(l)=sum(sum(phtmp))./sum(sum(ones(dx,dx)));
  if (dis==1)
     subplot(223)
     % imagesc(xpos(x-dx:x+dx),ypos(y-dx:y+dx),intmp);
     imagesc(xpos(x-dx:x+dx),ypos(y-dx:y+dx),cohtmp);colorbar
     hold on
  end

  if (dis==1)
     % nam=strrep(strrep(d(l).name,'tif','png'),'intensity','all');
     nam=strrep(strrep(d(l).name,'tif','png'),'intensity','allcoh');
     eval(['print -dpng -r300 ',nam]);
  end
end
phnya_cor=phnya-phcor;
phnya_nya=phnya-phnya2;
res=phnya_cor-phnya_nya;
figure
subplot(211)
plot(phnya*300/5400/2/pi)
hold on
plot(phnya2*300/5400/2/pi)
plot(phcor*300/5400/2/pi)
subplot(212)
plot(phnya_nya*300/5400/2/pi)
hold on
plot(phnya_cor*300/5400/2/pi)
plot(res*300/5400/2/pi)
