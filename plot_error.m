function plot_error(x,y,xe,ye)
hold on

if ye==0
    ye=zeros(size(y));
end

yeColor = [0	128/255	1];
xeColor = [0	128/255	1];

ye_bar = (max(y)-min(y))/100000;%/400;
xe_bar = (max(x)-min(x))/100000;%/400;

for i = 1:length(x)
    if xe(i) ~= 0
        ep=plot([(x(i) - xe(i)) (x(i) + xe(i))], [y(i) y(i)],'Color', xeColor);
        set(get(get(ep,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        hold on
        ep=plot([(x(i) - xe(i)) (x(i) - xe(i))], [(y(i)-ye_bar) (y(i)+ ye_bar)],'Color', xeColor);
        set(get(get(ep,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        hold on
        ep=plot([(x(i) + xe(i)) (x(i) + xe(i))], [(y(i)-ye_bar) (y(i)+ ye_bar)],'Color', xeColor);
        set(get(get(ep,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        hold on
    end
    if ye (i)~=0
        ep=plot([x(i) x(i)], [(y(i) - ye(i)) (y(i) + ye(i))],'Color', yeColor);
        set(get(get(ep,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        hold on
        ep=plot([(x(i)-xe_bar) (x(i)+ xe_bar)],[(y(i) - ye(i)) (y(i) - ye(i))], 'Color', yeColor);
        set(get(get(ep,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        hold on
        ep=plot([(x(i)-xe_bar) (x(i)+ xe_bar)],[(y(i) + ye(i)) (y(i) + ye(i))], 'Color', yeColor);
        set(get(get(ep,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        hold on
    end
end
end