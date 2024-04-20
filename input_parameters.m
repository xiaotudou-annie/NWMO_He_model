[num,txt,raw_all]=xlsread('Porewater report BH04',"parameters");

raw_all = raw_all(any(cellfun(@(raw_all)any(~isnan(raw_all)),raw_all),2),:); %delete rows with no numbers
raw_all = raw_all(:,any(cellfun(@(raw_all)any(~isnan(raw_all)),raw_all),1)); %delete colums with no numbers

parameters=cell2mat(raw_all(1:end,2));

flux_He4=parameters(1); %mol/m2yr
ASW_He4=parameters(2);
Depth=parameters(3); %m
temp_gradient = parameters(4);