function [Cold_He4,M,t]=Calc_cold_flux_RRa_conc(Cold_He4,pt_start, pt_end, t)

load('Calc_cold.mat');
M=struct('cdata',{},'colormap',{});

if calc_flux==1
    flx_name=[filestem '_flux.mat'];
    load(flx_name);
end

Cnew_He4=Cold_He4;


for it=1:pt_start-pt_end
    % He4
    Cold_He4=Cold_He4+P_He4(:,it)*dt;
    % Boundary matrix
    B_He4=Cold_He4(2:nz-1)-BC_He4;
    % numerical solution
    C_He4=A_He4\B_He4;
    Cnew_He4(2:nz-1)=C_He4;
    %Cnew_He4_loss=Cnew_He4(end)-ASW_He4;
    Cnew_He4(end)=ASW_He4;
    Cnew_He4(1)=(Dm_He4(1)*Cnew_He4(3)+2*dz*flux_He4)/(Dm_He4(1)+2*dz*q(1));
    
    %update time
    t=t+dt;                  % in sec
    tyrs=floor(t/secinyr);   % and in Myrs
    tmyrs=floor(t/secinmyr);   % and in Myrs

    an=2;
    if calc_flux==1  % only calculate the loss to atmosphere
        flux_b=-Dm_He4(nzb)/(an*dz)*(Cnew_He4(nzb)-Cnew_He4(nzb-an))+q(nzb)*Cnew_He4(nzb);
        flux_a=flux_b; %m3/m3/s
        net_F=flux_a-flux_b;
        net_F=net_F/22413.6*secinyr*1000000;        % m3/m2 s -> mol/m2 yr
        flux_b=flux_b/22413.6*secinyr*10^6;       % m3/m2 s -> mol/m2 yr
        flux_a=flux_a/22413.6*secinyr*10^6;       % m3/m2 s -> mol/m2 yr
        %production flux
        flux_p=sum(P_He4(:,it).*porosity'.*dz);                %P_He4=m3/m3 s Pore-water
        flux_p=flux_p*1/22413.6*secinyr*10^6;
        if tmax_yr-tyrs<1000000
            calc_F_sub=struct('time',(tmax_yr-tyrs)/10^6,'fluxb',flux_b,'fluxa',flux_a, 'netflux', net_F,'prod_flux',flux_p);
        else 
            calc_F_sub=struct('time',tmax-tmyrs,'fluxb',flux_b,'fluxa',flux_a, 'netflux', net_F,'prod_flux',flux_p);
        end
        Flx(1).calc_flux=[Flx.calc_flux calc_F_sub];
        
    end
   
    Cold_He4=Cnew_He4;
    %plot solutions
    %plot_4He_step
    
    pause(0.00005);
    if make_video==1
        M(it) = getframe(gcf);
    end
    
end
if calc_flux==1
    save(flx_name,'Flx', '-v7.3');
end
if calc_stable==1
    save(stability_name,'stability', '-v7.3')
end
end
