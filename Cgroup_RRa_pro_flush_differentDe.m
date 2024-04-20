function [Cnew_He4]=Cgroup_RRa_pro_flush_differentDe(Cinitial_He4,ntb_start,ntb_end,parameter_filename1)
load(parameter_filename1,'dt','dz','hydro_group','thickness','porosity','pro_He4','flux_He4','ASW_He4',...
    'make_video','calc_flux','calc_stable','flx_name','filestem','De_He4','nt');

secinmyr=1e6*365*24*3600;                                                   % amount of seconds in 1 Myr
secinyr=365*24*3600;                                                        % amount of seconds in 1 yr

% change units
dz;                  % m
thickness;                    % m
q=0;
q=q/10/1000/secinyr;    % m/10ka -> m/s  
flux_He4=flux_He4/10^6/secinyr*22413.6;  % mol/m2 yr -> m3/m2 s

pro_He4=pro_He4/secinyr;            % cc/cc yr -> m3/m3 s

tmax_yr=ntb_end*10^6; %yr
%---------------------------------------------
nz=sum(thickness)/dz+1;
z=0:dz:sum(thickness);                                                              % array for the finite difference mesh
nzb=1;                                              % find spatical steps for boundaries
for i=1:length(nzb)-1
    nzb(i)=ceil(sum(thickness(1:i))/dz+1);
end
nzb(end)=nz;

%
%q1=0*q;
q1=q*ones(nzb,1);
q=q1;

Dm_He4=De_He4;
%
s_He4=Dm_He4*dt/dz^2./porosity;                                                     %constant in the matrix for diffusion
%-------------------------  
s_B_He4=Dm_He4*dt/dz^2./porosity;                                                     %constant in the matrix for diffusion

%-------------------------  %darcy velocity m3/m2 s ---> cc/m2 s

r_He4=q1*dt./(porosity*dz); 
%constant in the matrix for advection
r_B_He4=q1*dt./(porosity*dz); 
%constant in the matrix for advection

%% Diagonal matrix A
% Diagonal matrix A

A_He4=diagA(nz,nzb,r_He4,r_B_He4, s_He4,s_B_He4);

A_He4(1,2)=-s_He4(2)*Dm_He4(2)/(Dm_He4(2)+2*dz*q1(2))-s_He4(3)+r_He4(3);

%%
%------------------ radiogenic prduction
P_He4=zeros(nz,1);                                                              % t=0 after the deposition of first layer

% Iinitial and boundary conditions:
Cold_He4=Cinitial_He4*ones(nzb,1);  % initial C=ASW for the new geologic layer ...
                            % top z=1
                            % bottom z=nz

% Boundary matrix
BC_He4=zeros(nzb(end)-2,1);
BC_He4(end)=-(s_B_He4(end)-r_B_He4(end))*ASW_He4;
BC_He4(1)=-2*flux_He4*dz*s_He4(2)/(Dm_He4(2)+2*dz*q1(2));                                     % basement = constant flux


Cnew_He4=Cold_He4;

P_He4=pro_He4(:,[find(nt==ntb_start):find(nt==ntb_end)-1]);

save('Calc_cold.mat','Dm_He4','q','P_He4','dt','nz','z',...
    'BC_He4','A_He4','ASW_He4','flux_He4','nzb','dz','hydro_group',...
    'make_video','secinmyr','secinyr','calc_flux','calc_stable','flx_name','filestem','porosity','tmax_yr');

%------------------------------------------------------------
M=struct('cdata',{},'colormap',{});

t=0;
[Cold_He4,sub_M,t]=Calc_cold_flux_RRa_conc(Cold_He4,ntb_start,ntb_end,t);
M=[M,sub_M];

if make_video==1
    load('Frame.mat')
    Frame=[Frame,M];
    save('Frame.mat','Frame', '-v7.3')
end
Cnew_He4=Cold_He4;

end