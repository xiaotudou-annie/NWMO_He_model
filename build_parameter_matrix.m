DAB_step=[0:1:Depth]';

% building porosity matrix
[row,~]=size(porosity_seg_matrix);
porosity_DAB_matrix=zeros(length(DAB_step),2);
for i=1:row
    row_no=intersect(find(DAB_step<porosity_seg_matrix(i,2)),find(DAB_step>=porosity_seg_matrix(i,1)));
    porosity_DAB_matrix(row_no,:)=repmat(porosity_seg_matrix(i,[3:4]),[length(row_no),1]);
end
porosity_DAB_matrix(end,:)=porosity_seg_matrix(i,3:4); %last row
porosity=porosity_DAB_matrix(:,1).*DAB_step+porosity_DAB_matrix(:,2);

% building geometric_factor matrix
[row,~]=size(geometric_factor_seg_matrix);
geometric_factor_DAB_matrix=zeros(length(DAB_step),2);
for i=1:row
    row_no=intersect(find(DAB_step<geometric_factor_seg_matrix(i,2)),find(DAB_step>=geometric_factor_seg_matrix(i,1)));
    geometric_factor_DAB_matrix(row_no,:)=repmat(geometric_factor_seg_matrix(i,[3:4]),[length(row_no),1]);
end
geometric_factor_DAB_matrix(end,:)=geometric_factor_seg_matrix(i,3:4); %last row
geometric_factor=geometric_factor_DAB_matrix(:,1).*DAB_step+geometric_factor_DAB_matrix(:,2);

% building density matrix
[row,~]=size(density_seg_matrix);
density_DAB_matrix=zeros(length(DAB_step),2);
for i=1:row
    row_no=intersect(find(DAB_step<density_seg_matrix(i,2)),find(DAB_step>=density_seg_matrix(i,1)));
    density_DAB_matrix(row_no,:)=repmat(density_seg_matrix(i,[3:4]),[length(row_no),1]);
end
density_DAB_matrix(end,:)=density_seg_matrix(i,3:4); %last row
density=density_DAB_matrix(:,1).*DAB_step+density_DAB_matrix(:,2);

[row,~]=size(U_seg_matrix);
U_DAB_matrix=zeros(length(DAB_step),2);
for i=1:row
    row_no=intersect(find(DAB_step<U_seg_matrix(i,2)),find(DAB_step>=U_seg_matrix(i,1)));
    U_DAB_matrix(row_no,:)=repmat(U_seg_matrix(i,[3:4]),[length(row_no),1]);
end
U_DAB_matrix(end,:)=U_seg_matrix(i,3:4); %last row
U_conc_ppm=U_DAB_matrix(:,1).*DAB_step+U_DAB_matrix(:,2);

[row,~]=size(Th_seg_matrix);
Th_DAB_matrix=zeros(length(DAB_step),2);
for i=1:row
    row_no=intersect(find(DAB_step<Th_seg_matrix(i,2)),find(DAB_step>=Th_seg_matrix(i,1)));
    Th_DAB_matrix(row_no,:)=repmat(Th_seg_matrix(i,[3:4]),[length(row_no),1]);
end
Th_DAB_matrix(end,:)=Th_seg_matrix(i,3:4); %last row
Th_conc_ppm=Th_DAB_matrix(:,1).*DAB_step+Th_DAB_matrix(:,2);

[row,~]=size(K_seg_matrix);
K_DAB_matrix=zeros(length(DAB_step),2);
for i=1:row
    row_no=intersect(find(DAB_step<K_seg_matrix(i,2)),find(DAB_step>=K_seg_matrix(i,1)));
    K_DAB_matrix(row_no,:)=repmat(K_seg_matrix(i,[3:4]),[length(row_no),1]);
end
K_DAB_matrix(end,:)=K_seg_matrix(i,3:4); %last row
K_conc_ppm=K_DAB_matrix(:,1).*DAB_step+K_DAB_matrix(:,2);

T=293.15+temp_gradient*DAB_step;           % K
D0_He4=2.309*10^-2*exp( -1706./T);          % cm2/s
D0_He4=D0_He4*10^-4;                        % cm2/s -> m2/s

De_He4=geometric_factor.*porosity.*D0_He4;                  %m2/s


save('mc_parameters.mat','porosity_seg','porosity','density','density_seg','geometric_factor',...
    'geometric_factor_seg', 'De_He4','U_conc_ppm','Th_conc_ppm','K_conc_ppm')