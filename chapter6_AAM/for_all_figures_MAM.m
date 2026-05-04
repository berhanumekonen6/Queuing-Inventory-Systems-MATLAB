%% Main Script to Generate All Figures for MAM QIS Paper
clear all; close all; clc;

% Generate all figures
fig1 = fig1_MAM();
fig2 = fig2_plotCostSurface();
fig3 = fig3_plotSensitivityAnalysis();
fig4 = fig_4plotCatastropheImpact();
fig5 = fig_5plotPerformanceComparison();

fprintf('All 5 figures generated successfully!\n');