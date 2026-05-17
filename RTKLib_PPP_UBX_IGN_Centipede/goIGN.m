clear all
close all
m=1;
for year=2024:2026
   for day=1:365
      if (year==2022)
         j=mod(day+6,7)
         w=2190+floor((day+6-1)/7)
      end
      if (year==2023)
         j=mod(day+0,7)
         w=2243+floor((day+0-1)/7)
      end
      if (year==2024)
         j=mod(day+1,7)
         w=2295+floor((day+1-1)/7)
      end
      if (year==2025)
         j=mod(day+3,7)
         w=2347+floor((day+3-1)/7)
      end
      if (year==2026)
         j=mod(day+4,7)
         w=2399+floor((day+4-1)/7) % https://www.gnsscalendar.com/
      end
      if (exist(['out',num2str(year),'_',num2str(day,"%03d")])==0)
         nomENSMM=['BSCN00FRA_R_',num2str(year),num2str(day,'%03d'),'0000_01D_30S_MO.crx'];
	% https://rgpdata.ign.fr/pub/data_v3/2026/015/data_30/BSCN00FRA_R_20260150000_01D_30S_MO.crx.gz
	 if (exist(strrep(nomENSMM,'.gz',''))==0)
           system(['wget https://rgpdata.ign.fr/pub/data_v3/',num2str(year),'/',num2str(day,"%03d"),'/data_30/',nomENSMM,'.gz']);
           system(['gunzip -f ',nomENSMM,'.gz']);
           system(['../RNXCMP_4.2.0_src/source/crx2rnx -f ',nomENSMM]);
           system(['../RTKLIB_2.4.3/app/consapp/convbin/gcc/convbin ',strrep(nomENSMM,'crx','rnx')]);
	 end
         nomnav=['auto',num2str(day,'%03d'),'0.',num2str(year-2000),'n']
         nomsp3_05=['JPL0OPSRAP_',num2str(year),num2str(day,"%03d"),'0000_01D_05M_ORB.SP3']
         nomsp3_15=['JPL0OPSRAP_',num2str(year),num2str(day,"%03d"),'0000_01D_15M_ORB.SP3']
         nomclk=['JPL0OPSRAP_',num2str(year),num2str(day,"%03d"),'0000_01D_30S_CLK.CLK']
	 tmp=eval(['dir(''auto',num2str(day,"%03d"),'*',num2str(year-2000),'n'')'])
	 if (isempty(tmp))
            system(['wget http://garner.ucsd.edu/pub/rinex/',num2str(year),'/',num2str(day,"%03d"),'/',nomnav,'.Z']);
	    system('uncompress -f *Z')
	 end
	 tmp=eval(['dir(''',nomsp3_05(1:18),'*ORB*'')']);
	 if (isempty(tmp))
            system(['wget http://garner.ucsd.edu/pub/products/',num2str(w),'/',nomsp3_05,'.gz']);
            if (exist([nomsp3_05,'.gz'])==0)
               nomsp3=nomsp3_15;
               system(['wget http://garner.ucsd.edu/pub/products/',num2str(w),'/',nomsp3_15,'.gz']);
	    else
               nomsp3=nomsp3_05;
            end
            system('gunzip -f *gz');
            system(['mv ',nomsp3,' ',strrep(nomsp3,'SP3','sp3')]);
	 end
	 tmp=eval(['dir(''',nomclk(1:24),'*CLK*'')']);
	 if (isempty(tmp))
            system(['wget http://garner.ucsd.edu/pub/products/',num2str(w),'/',nomclk,'.gz']);
            system('gunzip -f *gz');
            system(['mv ',nomclk,' ',strrep(nomclk,'.CLK','.clk')]);
	 end
         if (exist(strrep(nomsp3_05,'SP3','sp3'))==0)
            nomsp3=nomsp3_15;
         else
            nomsp3=nomsp3_05;
         end
         cmd=(['../RTKLIB_2.4.3/app/consapp/rnx2rtkp/gcc/rnx2rtkp -c -o out',num2str(year),'_',num2str(day,"%03d"),' -k ./config.jmf ',strrep(nomENSMM,'crx','obs'),' ','auto',num2str(day,"%03d"),'0.',num2str(year-2000),'n ',strrep(nomsp3,'SP3','sp3'),' ',strrep(nomclk,'.CLK','.clk')])
%         cmd=(['../RTKLIB_2.4.3/app/consapp/rnx2rtkp/gcc/rnx2rtkp -c -o out',num2str(year),'_',num2str(day,"%03d"),' -k ./config.jmf ',strrep(nomENSMM,'crx.gz','rnx'),' ','auto',num2str(day,"%03d"),'0.',num2str(year-2000),'n ',strrep(nomsp3,'SP3','sp3')])
	 system(cmd);
      end
      if (exist(['out',num2str(year),'_',num2str(day,"%03d")]))
         x=dlmread(['out',num2str(year),'_',num2str(day,"%03d")],'',10,0);
         if (isempty(x)==0)
            k=find(x(:,6)==6);
            x=x(k,:);
            soly(m)=mean(x(:,3))
            solx(m)=mean(x(:,4))
            solz(m)=mean(x(:,5))
            stdy(m)=std(x(:,3)/360*40000000);
            stdx(m)=std(x(:,4)/360*40000000)*cosd(soly(m));
            stdz(m)=std(x(:,5));
         end
      end
      m=m+1;
   end
end
%http://garner.ucsd.edu/pub/rinex/2024/268/  OBS
%http://garner.ucsd.edu/pub/products/2363/   SP3 et CLOCK (week + day in week)
save -mat all.mat
