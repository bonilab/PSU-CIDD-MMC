% format_axis.m
% 
% Formats the axis for EIR vs. PfPR plots, presumes that `hold on` has
% already been set.
function [] = format_axis()
    xlabel('EIR', 'fontsize', 24);
    xlim([-2 3]);
    xticks([-4 -3 -2 -1 0 1 2 3 4]);
    xticklabels({'0.0001', '0.001', '0.01', '0.1', '1', '10', '100', '1,000', '10,000'});
    ylabel('PfPR_{2-10}', 'fontsize', 24);
    ylim([0 100]);
end