% mmc_rainy.m
%
% Generate the plot for the second round MMC data with and without rain.
addpath('include');
clear;

hold on;
labels = {};

labels{end + 1} = plot_rainy('data/mmc-ii-rainy.csv');
labels{end + 1} = plot_steady('data/mmc-ii.csv');
labels{end + 1} = plot_liturature();

title({'MMC Benchmarking EIR vs. PfPR_{2 to 10}'}, 'fontsize', 35);
legend(labels, 'Location', 'northwest', 'NumColumns', 2);
legend('boxoff');

format_axis();
plot = gca;
plot.FontSize = 18;

hold off;

function [label] = plot_rainy(filename)
    BETA = 3; EIR = 4; PFPR = 6;

    data = csvread(filename, 1, 0);
    betas = transpose(unique(data(:, BETA)));
    index = 1;
    pfpr = zeros(size(betas, 1), 1);
    eir = zeros(size(betas, 1), 1);
    for beta = betas
        if size(data(data(:, BETA) == beta, PFPR), 1) < 3
            continue;
        end
        peaks = findpeaks(data(data(:, BETA) == beta, PFPR));
        pfpr(index) = mean(peaks);
        eir(index) = log10(mean(data(data(:, BETA) == beta, EIR)));
        index = index + 1;
    end
    scatter(eir, pfpr, 'filled');    
	label = "Seasonal Variation";
end


