% plot_liturature.m
%
% Plots the liturature data provided by the MMC. Presumes that `hold on` 
% has already been set.
function [label] = plot_liturature()
    EIR = 2; PFPR = 3;
    carlos = csvread('data/liturature.csv', 1, 0);
    scatter(carlos(:, EIR), carlos(:, PFPR) * 100);
    label = "Individual Prevalence Survey";
end

