pkg load mapping
format long

if (isempty(argv)==0)
	nom=argv{1};
else
        d=dir('final*intensity*tif');
	nom=d(1).name;
end

% ROI
xstart=436900
xstop=xstart+4000
ystart=8755200
ystop=ystart+4000

nom
x=rasterread(nom);
x.bbox
xpos=linspace(x.bbox(1,1),x.bbox(2,1),size(x.data)(2)); % larger
ypos=linspace(x.bbox(1,2),x.bbox(2,2),size(x.data)(1)); % smaller
xk=find((xpos>=xstart)&(xpos<=xstop));
yk=find((ypos>=ystart)&(ypos<=ystop));
xpos=xpos(xk);
ypos=ypos(yk);
intens=x.data(yk,xk);
k=find(intens==0);intens(k)=NaN;
%imagesc(10*log10(intens),[50 90])
%axis xy
%axis square
eval(['save -mat ',strrep(nom,'tif','mat'),' intens']);
