clear all
close all
clc

input_matrix    = [ ...
    100 100 50; ...
    100 -100 50; ...
    50 50 200; ...
    ];
PlotJack(input_matrix)

input_matrix    = [ ...
    100 100 50; ...
    100 -100 51; ...
    50 50 200; ...
    ];
PlotJack(input_matrix)