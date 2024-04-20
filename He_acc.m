function He4_pro_cc_cc=He_acc(start_time, end_time, porosity,U_conc_ppm, Th_conc_ppm)
%======================================================================
%Xr=fractional natural abundance:238=0.9928; 235= 0.0072; 232=1
%lambda: 238 = 1.55E(-10);235=9.85E(-10);232=4.95E(-11)
%NA=Avogadro's number = 6.023E(23)
%t=age(yr)
%Ar= molar mass: 238; 235; 232
%yield:No of alpha particles emitted in the complete decay chain:238=8;235= 7; 232=6
%production of 4He (atoms/g)=Xr * [K] *10^(-6) * (NA/Ar) * yield *(e^(lambda*t) - 1)

%constant = Xr *10^(-6) * (NA/Ar) (lambda e/ lambda k) *yield
%production of 4He (atoms/g)=(constant238*[U]*(e^(lambda238*t)-1)+(constant235*[U]*(e^(lambda235*t)-1)+(constant232*[Th]*(e^(lambda232*t)-1)

lambda238 =1.55*10^(-10);
lambda235=9.85*10^(-10);
lambda232=4.95*10^(-11);
constant238 = 8*10^(-6) * (6.022*10^(23)/238)*0.9928;
constant235 = 7*10^(-6) * (6.022*10^(23)/235)*0.0072;
constant232 = 6*10^(-6) * (6.022*10^(23)/232)*1;

t_yr=start_time;
start_atom_He4_crust_rock_mass=constant238*U_conc_ppm*(exp(lambda238*t_yr)-1)+constant235*U_conc_ppm*(exp(lambda235*t_yr)-1)+constant232*Th_conc_ppm*(exp(lambda232*t_yr)-1);

t_yr=end_time;
end_atom_He4_crust_rock_mass=constant238*U_conc_ppm*(exp(lambda238*t_yr)-1)+constant235*U_conc_ppm*(exp(lambda235*t_yr)-1)+constant232*Th_conc_ppm*(exp(lambda232*t_yr)-1);

atom_He4_crust_rock_mass=(start_atom_He4_crust_rock_mass-end_atom_He4_crust_rock_mass)/(start_time-end_time);
%%
rock_density=2.7; %g/cm3

He4_pro_mol_gram_rock_mass=atom_He4_crust_rock_mass/(6.022*10^23); %mol/g of rock
He4_pro_mol_g=He4_pro_mol_gram_rock_mass.*rock_density./porosity; % mol/g of porewater
He4_pro_cc_cc=He4_pro_mol_g*22413.6; %cc/cc of porewater

end