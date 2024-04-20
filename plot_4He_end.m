figure(1)
clf
%plot layers
nz=thickness/dz+1;
nzb=nz;
z=0:dz:sum(thickness);    
xb=[];
yb=[];
for ib=1:length(nzb)
    xb=[xb [-50 10000 nan]];
    yb=[yb [nzb(ib) nzb(ib) nan]];
end
h=line(xb,yb*dz);
set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');

% plot solution:
hold on
plotConc=plot (Conc_He4,z,'LineWidth',1.8);
for i=1:length(plotConc)
    set(get(get(plotConc(i),'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
end
xlabel('^4He cm^3/cm^3 H_2O');
%
set(gca,'FontSize',16);

ylim([0,nzb])
xlim([0,max(max(Conc_He4))])
    
  