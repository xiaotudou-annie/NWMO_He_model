[num,txt,raw_all]=xlsread('Porewater report BH04',Import_file_name);

raw_all = raw_all(any(cellfun(@(raw_all)any(~isnan(raw_all)),raw_all),2),:); %delete rows with no numbers
raw_all = raw_all(:,any(cellfun(@(raw_all)any(~isnan(raw_all)),raw_all),1)); %delete colums with no numbers

sample_depth=cell2mat(raw_all(3:end,2));
sample_DAB=flipud(Depth-sample_depth);

% rearrange so that the deepest is the first entry
density_seg=flipud(cell2mat(raw_all(3:end,3)));   %g/cm3
porosity_average=flipud(cell2mat(raw_all(3:end,4))/100);
porosity_error=flipud(cell2mat(raw_all(3:end,5))/100);
geometric_factor_max=flipud(cell2mat(raw_all(3:end,6)));
geometric_factor_min=flipud(cell2mat(raw_all(3:end,7)));
geometric_factor_average=flipud(cell2mat(raw_all(3:end,8)));

%% random porosity value from a normal distribution
porosity_seg=normrnd(porosity_average, porosity_error);
porosity_DAB=sample_DAB(~isnan(porosity_seg));
porosity_seg=porosity_seg(~isnan(porosity_seg));

% construct linear functions between every two points
porosity_seg_matrix=zeros(length(porosity_DAB)-1,4);  %[minDAB maxDAB, gradient, y-intercept]
for i=1:length(porosity_DAB)-1
    [p,s] = polyfit([porosity_DAB(i) porosity_DAB(i+1)],[porosity_seg(i) porosity_seg(i+1)],1);
    porosity_seg_matrix(i,:)=[porosity_DAB(i) porosity_DAB(i+1) p];
end
top_porosity_seg_matrix=[0, porosity_DAB(1) 0 porosity_seg(1)];
porosity_seg_matrix=[top_porosity_seg_matrix;porosity_seg_matrix];

if Depth>porosity_DAB(end)
    end_porosity_seg_matrix=[porosity_DAB(end), Depth, 0 porosity_seg(end)];
    porosity_seg_matrix=[porosity_seg_matrix;end_porosity_seg_matrix];
end

%% random geometric_factor value from a normal distribution
% The average value and the min max middle point is almos the same
% assume normal distribution with max-min represent 6 sigma
geometric_factor_error=(geometric_factor_max-geometric_factor_min)/6;
geometric_factor_seg=normrnd(geometric_factor_average, geometric_factor_error);

geometric_factor_DAB=sample_DAB(~isnan(geometric_factor_seg));
geometric_factor_seg=geometric_factor_seg(~isnan(geometric_factor_seg));

% construct linear functions between every two points
geometric_factor_seg_matrix=zeros(length(geometric_factor_DAB)-1,4);  %[minDAB maxDAB, gradient, y-intercept]
for i=1:length(geometric_factor_DAB)-1
    [p,s] = polyfit([geometric_factor_DAB(i) geometric_factor_DAB(i+1)],[geometric_factor_seg(i) geometric_factor_seg(i+1)],1);
    geometric_factor_seg_matrix(i,:)=[geometric_factor_DAB(i) geometric_factor_DAB(i+1) p];
end
top_geometric_factor_seg_matrix=[0, geometric_factor_DAB(1) 0 geometric_factor_seg(1)];
geometric_factor_seg_matrix=[top_geometric_factor_seg_matrix;geometric_factor_seg_matrix];

if Depth>geometric_factor_DAB(end)
    end_geometric_factor_seg_matrix=[geometric_factor_DAB(end), Depth, 0 geometric_factor_seg(end)];
    geometric_factor_seg_matrix=[geometric_factor_seg_matrix;end_geometric_factor_seg_matrix];
end

%% Density
% construct linear functions between every two points

density_DAB=sample_DAB(~isnan(density_seg));
density_seg=density_seg(~isnan(density_seg));

density_seg_matrix=zeros(length(density_DAB)-1,4);  %[minDAB maxDAB, gradient, y-intercept]
for i=1:length(density_DAB)-1
    [p,s] = polyfit([density_DAB(i) density_DAB(i+1)],[density_seg(i) density_seg(i+1)],1);
    density_seg_matrix(i,:)=[density_DAB(i) density_DAB(i+1) p];
end
top_density_seg_matrix=[0, density_DAB(1) 0 density_seg(1)];
density_seg_matrix=[top_density_seg_matrix;density_seg_matrix];

if Depth>density_DAB(end)
    end_density_seg_matrix=[density_DAB(end), Depth, 0 density_seg(end)];
    density_seg_matrix=[density_seg_matrix;end_density_seg_matrix];
end
%%
[num,txt,raw_all]=xlsread('Porewater report BH04','UTh');

raw_all = raw_all(any(cellfun(@(raw_all)any(~isnan(raw_all)),raw_all),2),:); %delete rows with no numbers
raw_all = raw_all(:,any(cellfun(@(raw_all)any(~isnan(raw_all)),raw_all),1)); %delete colums with no numbers

sample_depth=cell2mat(raw_all(7:end,2));
U_conc_ppm_seg=cell2mat(raw_all(7:end,3));
Th_conc_ppm_seg=cell2mat(raw_all(7:end,4));
K_conc_ppm_seg=cell2mat(raw_all(7:end,5))*10000;

conc_DAB=flipud(Depth-sample_depth);

% rearrange so that the deepest is the first entry
U_conc_ppm_seg=flipud(U_conc_ppm_seg);   
Th_conc_ppm_seg=flipud(Th_conc_ppm_seg);
K_conc_ppm_seg=flipud(K_conc_ppm_seg);

% construct linear functions between every two points

U_seg_matrix=zeros(length(conc_DAB)-1,4);  %[minDAB maxDAB, gradient, y-intercept]
Th_seg_matrix=zeros(length(conc_DAB)-1,4);  %[minDAB maxDAB, gradient, y-intercept]
K_seg_matrix=zeros(length(conc_DAB)-1,4);  %[minDAB maxDAB, gradient, y-intercept]
for i=1:length(conc_DAB)-1
    [p_U,s] = polyfit([conc_DAB(i) conc_DAB(i+1)],[U_conc_ppm_seg(i) U_conc_ppm_seg(i+1)],1);
    [p_Th,s] = polyfit([conc_DAB(i) conc_DAB(i+1)],[Th_conc_ppm_seg(i) Th_conc_ppm_seg(i+1)],1);
    [p_K,s] = polyfit([conc_DAB(i) conc_DAB(i+1)],[K_conc_ppm_seg(i) K_conc_ppm_seg(i+1)],1);
    U_seg_matrix(i,:)=[conc_DAB(i) conc_DAB(i+1) p_U];
    Th_seg_matrix(i,:)=[conc_DAB(i) conc_DAB(i+1) p_Th];
    K_seg_matrix(i,:)=[conc_DAB(i) conc_DAB(i+1) p_K];
end
top_U_conc_ppm_matrix=[0, conc_DAB(1) 0 U_conc_ppm_seg(1)];
U_seg_matrix=[top_U_conc_ppm_matrix;U_seg_matrix];

top_Th_conc_ppm_matrix=[0, conc_DAB(1) 0 Th_conc_ppm_seg(1)];
Th_seg_matrix=[top_Th_conc_ppm_matrix;Th_seg_matrix];

top_K_conc_ppm_matrix=[0, conc_DAB(1) 0 K_conc_ppm_seg(1)];
K_seg_matrix=[top_K_conc_ppm_matrix;K_seg_matrix];

if Depth>conc_DAB(end)
    end_U_conc_ppm_matrix=[conc_DAB(end), Depth, 0 U_conc_ppm_seg(end)];
    end_Th_conc_ppm_matrix=[conc_DAB(end), Depth, 0 Th_conc_ppm_seg(end)];
    end_K_conc_ppm_matrix=[conc_DAB(end), Depth, 0 K_conc_ppm_seg(end)];
    
    U_seg_matrix=[U_seg_matrix;end_U_conc_ppm_matrix];
    Th_seg_matrix=[Th_seg_matrix;end_Th_conc_ppm_matrix];
    K_seg_matrix=[K_seg_matrix;end_K_conc_ppm_matrix];
end