clear;
close all;
data = nicering;

grid_width = 10;
grid_height = 10;
steps = 15000;
learning_rate = 0.1;
radius = 5;

[som, grid] = lab_som2d(data, grid_width, grid_height, steps, learning_rate, radius);
lab_vis2d(som, grid, data);