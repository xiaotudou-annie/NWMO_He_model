it=1;
porosity_collection=[];
porosity_seg_collection=[];
density_collection=[];
density_seg_collection=[];
geometric_factor_collection=[];
geometric_factor_seg_collection=[];
De_He4_collection=[];
Conc_He4_collection=[];
save('mc_parameters_collection.mat','porosity_seg_collection','porosity_collection',...
    'density_collection','density_seg_collection','geometric_factor_collection',...
    'geometric_factor_seg_collection', 'De_He4_collection','Conc_He4_collection','it')
while it<200
    R0_simple_box_constant_flux_He
    load('mc_parameters.mat')
    load('mc_parameters_collection.mat')
    
    porosity_seg_collection=[porosity_seg_collection,porosity_seg];
    porosity_collection=[porosity_collection, porosity];
    density_collection=[density_collection density];
    density_seg_collection=[density_seg_collection density_seg];
    geometric_factor_collection=[geometric_factor_collection geometric_factor];
    geometric_factor_seg_collection=[geometric_factor_seg_collection geometric_factor_seg];
    De_He4_collection=[De_He4_collection De_He4];
    Conc_He4_collection=[Conc_He4_collection Conc_He4];
    
    it=it+1
    
    save('mc_parameters_collection.mat','porosity_seg_collection','porosity_collection',...
    'density_collection','density_seg_collection','geometric_factor_collection',...
    'geometric_factor_seg_collection', 'De_He4_collection','Conc_He4_collection','it')
end

figure

bin_number=8;
DAB_Depth=DAB_step-Depth;
porosity_DAB_Depth=porosity_DAB-Depth;
geometric_factor_DAB_Depth=geometric_factor_DAB-Depth;

%% transparency plot

frequency_plot_transparency(Conc_He4_collection,DAB_Depth,bin_number)
xlim([0,max(max(Conc_He4_collection))])
title({sprintf('Flux in = %.3g mol m^{-2}yr^{-1}', flux_He4), ['Groundwater Residence Age = ' num2str(start_age) ' Myr']})
xlabel('^4He cm^3/cm^3 H_2O');
ylabel('Depth (m)');