function frequency_plot_transparency(porosity_collection, depth_step,bin_number)
    bin_bounds=zeros(length(depth_step),bin_number+1);
    nHist_values=zeros(length(depth_step),bin_number);
    for il=1:length(depth_step)
        nHist=histogram(porosity_collection(il,:),bin_number);
        bin_bounds(il,:)=nHist.BinEdges;
        nHist_values(il,:)=nHist.Values;
        close all
        il;
    end

    max_values=max(max(nHist_values));
    if max_values==length(porosity_collection(1,:))
        max_values=max(nHist_values(nHist_values<max_values));
    end
    min_values=min(min(nHist_values));

        %create colors for each number of occurance
        %colors=jet(max_values-min_values+1);
        %colormap(colors);

        trans_alpha=0:1./(max_values-min_values):1;

        %construct a color matrix
        %cMatrix=colors(nHist_values, :);
    for il=1:length(depth_step)-1    
        for ic=1:bin_number
            %cMatrix=colors(find(nHist_values(il,ic)==[min_values:max_values]),:);
            %plot([bin_bounds(il,ic), bin_bounds(il,ic+1)],[-depth_step(il),-depth_step(il)],'Color', cMatrix,'LineWidth',3)
            transparency=trans_alpha(find(nHist_values(il,ic)==[min_values:max_values]));
            p1=plot([bin_bounds(il,ic), bin_bounds(il,ic+1)],[depth_step(il),depth_step(il)],'Color','r','LineWidth',3);
            p1.Color(4) = transparency;
            hold on
        end
        %il
        pause(0.01)
    end
    
    xlim([0,max(max(porosity_collection))])
end