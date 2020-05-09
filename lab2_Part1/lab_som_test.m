clear;
close all;

data = nicering;
numNeurons=20;
steps = 5000;
learningRate = 0.1;
radius = 10;

som=lab_som(data, numNeurons, steps, learningRate, radius);
lab_vis(som, data);