% plot_steady.m
% 
% Plot the steady-state EIR vs PfPR data.
function [label] = plot_steady(filename)
    EIR = 3; PFPR = 5;
    data = csvread(filename, 1, 0);
    scatter(log10(data(:, EIR)), data(:, PFPR), 'filled');
    label = "No Seasonal Variation";
end