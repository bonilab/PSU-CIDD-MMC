% boni_extended.m
%
% Analysis script to compare various base variable parameters, in tamdum
% with the MMC work that is being conducted.
addpath('include');
clear;

% Plot the rainy plots, these will automatically format themselves
plot_rainy('data/boni-extended-rainy.csv');

% Plot the steady-state plot
subplot(3, 2, 6);
hold on;
label = plot_steady('data/mmc-ii.csv');
plot_liturature();
format_axis();
title(label, 'fontsize', 24);
hold off;

function [] = plot_rainy(filename)
    BASE = 3; BETA = 4; EIR = 5; PFPR = 7;

    % Load the data and note common values
    raw = csvread(filename, 1, 0);
    bases = unique(raw(:, BASE));
    betas = transpose(unique(raw(:, BETA)));
    
    % Iterate through each base, create new graph
    spi = 1;
    for base = transpose(bases)
        
        % Filter the data
        data = raw(raw(:, 3) == base, :);
        
        % Prepare the subplot
        hold on;
        subplot(3, 2, spi);
            
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
        
        % Wrap-up the plot
        title(sprintf("Seasonal base, %g", base), 'fontsize', 24);
        format_axis();
        hold off;
        
        % Move to the next subplot
        spi = spi + 1;
    end
    

end
