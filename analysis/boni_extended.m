% boni_extended.m
%
% Analysis script to compare various base variable parameters, in tamdum
% with the MMC work that is being conducted.
addpath('include');
clear;

comparison();


function [] = comparison()
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
end

% Work in progress - plots the peaks and demonstrates that local maxima
% were being picked up which was skewing the reuslts
function [] = working()
    DATES = 2; BASE = 3; BETA = 4; EIR = 5; PFPR = 7;
    raw = csvread('data/boni-extended-rainy.csv', 1, 0);
    dates = unique(raw(:, DATES));
    bases = unique(raw(:, BASE));
    betas = unique(raw(:, BETA));

    base = 0.5;
    data = raw(raw(:, BASE) == base, :);

    spi = 1;
    for beta = transpose(betas)
        subplot(5, 40, spi);
        filtered = data(data(:, BETA) == beta, :);
    %    plot(filtered(:, DATES), filtered(:, PFPR));
        findpeaks(filtered(:, PFPR));
        title(sprintf("%g", beta));
        spi = spi + 1;
    end
end

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
            
            % Discard empty data sets
            if size(max(peaks), 1) == 0
                continue;
            end
            
            peaks = findpeaks(peaks);
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
