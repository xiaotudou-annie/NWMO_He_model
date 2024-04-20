clear all
close all

% User input
input_parameters

Import_file_name='porosity water content';
Import_parameters

filestem='MC_He';  %MC - monto carlo
hydro_group='Precambrian Basement';

%% --------------------------------------
% method: finite differences, backward Euler time integration
% basement: constant flux
% surface: constant concentration

start_age=2;   % empty [] = default = max(age)                       
end_age=0;   %model to 1Ma, than change another programme for flushing

make_video=0;
calc_flux=1;
calc_stable=0;
perc_pro_He=1;              

%% define parameters
dt =1;                       % timestep in Myrs
secinmyr=1e6*365*24*3600;       % amount of seconds in 1 Myr
secinyr=365*24*3600;            % amount of seconds in 1 Myr

nt=fliplr((end_age:dt:start_age)*10^6); %unit in yrs

dt=dt*secinmyr;                 % unit conversion to SI: time in sec

dz=1;                         % discretization step in m

build_parameter_matrix

pro_He4=zeros(length(porosity),length(nt));
for i=1:length(nt)-1
    pro_He4(:,i)=He_acc(nt(i), nt(i+1), porosity,U_conc_ppm, Th_conc_ppm); %cc/cc of porewater
end
thickness=Depth;
%% Iinitial and boundary conditions:
Cold_He4=ASW_He4;    % initial C=ASW everywhere ...
                                % top z=1
                                % bottom z=n

%-------------------------------------
Frame=struct('cdata',{},'colormap',{});
save('Frame.mat','Frame','-v7.3');

%calculating flux
flx_name=[filestem '_flux.mat'];
if calc_flux==1
    calc_F=struct('time',{},'fluxb',{},'fluxa',{},'netflux',{},'prod_flux',{}); 
    % netflux = net flux at the boundary
    % fluxb=flux from layers below
    % fluxb=flux to layers above
    hydro_g=hydro_group;
    Flx=struct('formation_top',hydro_g,'calc_flux',calc_F);
    %flx_name=[filestem 'flux_' num2str(plotgroup) '.mat'];
    save(flx_name,'Flx','-v7.3');
    clear calc_F; clear Flx;
end
%-------------------------------------
ntb=ceil([start_age end_age]*secinmyr/dt) ;                 % round up to the next integer
nt=nt*secinyr/dt;

save('parameters.mat')

%% 


[Cold_He4]=Cgroup_RRa_pro_flush_differentDe(Cold_He4,ntb(1),ntb(2),'parameters.mat');

Conc_He4=Cold_He4;
filename = [filestem,'.mat'];

save(filename,'Conc_He4','Depth','dz','hydro_group',...
    'flux_He4','make_video','calc_flux','-v7.3');

video_name=[filestem,'.avi'];
if make_video==1
    load Frame.mat
    v = VideoWriter(video_name,'Motion JPEG AVI');
    v.FrameRate=20;
    open(v)
    writeVideo(v,Frame)
    close(v)
end

plot_4He_end

%% ---------
ylabeltext=['Distance above the -' num2str(Depth) 'm level (m)'];
ylabel(ylabeltext);
xlim([0,Conc_He4(max(z)-1000+1)*1.1]);ylim([max(z)-1000, max(z)])
%xlim([0,max(Conc_He4)*1.1]);

set(gcf, 'Position', [0,0,900,800])

title({['Porewater Report ' ],sprintf('Flux in = %.3g mol m^{-2}yr^{-1}', flux_He4), ['Groundwater Residence Age = ' num2str(start_age) ' Myr']})