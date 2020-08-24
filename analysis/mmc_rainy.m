% mmc_rainy.m
%
% Generate the plot for the second round MMC data with and without rain.
clear;

% Prepare for the labels
global labels;
labels = {};

% Add the data
hold on;
plot_rainy();
plot_steady();
liturature();

% Format the plot
xlabel('EIR', 'fontsize', 24);
xlim([-2 3]);
xticks([-4 -3 -2 -1 0 1 2 3 4]);
xticklabels({'0.0001', '0.001', '0.01', '0.1', '1', '10', '100', '1,000', '10,000'});

ylabel('PfPR_{2-10}', 'fontsize', 24);
ylim([0 100]);

title({'MMC Benchmarking EIR vs. PfPR_{2 to 10}'}, 'fontsize', 35);

legend(labels, 'Location', 'northwest', 'NumColumns', 2);
legend('boxoff');

plot = gca;
plot.FontSize = 18;

hold off;

% hold on;
% high = csvread('data/mmc-ii-rainy.csv', 1, 0);
% high = high(high(:, 3) == 0.5, :);
% plot(high(:, 2), high(:, 6));
% 
% low = csvread('data/mmc-ii-rainy-0.1.csv', 1, 0);
% low = low(low(:, 3) == 0.5, :);
% plot(low(:, 2), low(:, 6));
% ylabel('PfPR_{2 to 10}');
% xlabel('Days Elapsed');
% legend('1-2x Season', '0.1-1x Season');
% legend('boxoff');
% hold off;

function [] = plot_rainy()
    BETA = 3; EIR = 4; PFPR = 6;

    data = csvread('data/mmc-ii-rainy.csv', 1, 0);
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
    
    writematrix([eir; pfpr]', 'mmc-rain.csv');
    
	global labels;
    labels{end + 1} = "Seasonal Variation";
end

function [] = plot_steady()
    EIR = 3; PFPR = 5;
    data = csvread('data/mmc-ii.csv', 1, 0);
    scatter(log10(data(:, EIR)), data(:, PFPR), 'filled');
    
%    writematrix([log10(data(:, EIR)) data(:, PFPR)], 'mmc-steady.csv');
    
    global labels;
    labels{end + 1} = "No Seasonal Variation";
end

function [] = liturature() 
    EIR = 2; PFPR = 3;
    carlos = csvread('data/liturature.csv', 1, 0);
    scatter(carlos(:, EIR), carlos(:, PFPR) * 100);

	global labels;
    labels{end + 1} = "Individual Prevalence Survey";
end
