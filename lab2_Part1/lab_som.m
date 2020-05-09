function som = lab_som (trainingData, neuronCount, trainingSteps, startLearningRate, startRadius)
% som = lab_som (trainingData, neuronCount, trainingSteps, startLearningRate, startRadius)
% -- Purpose: Trains a 1D SOM i.e. A SOM where the neurons are arranged
%             in a single line. 
%             
% -- <trainingData> data to train the SOM with
% -- <som> returns the neuron weights after training
% -- <neuronCount> number of neurons 
% -- <trainingSteps> number of training steps 
% -- <startLearningRate> initial learning rate
% -- <startRadius> initial radius used to specify the initial neighbourhood size

% TODO:
% The student will need to complete this function so that it returns
% a matrix 'som' containing the weights of the trained SOM.
% The weight matrix should be arranged as follows, where
% N is the number of features and M is the number of neurons:
%
% Neuron1_Weight1 Neuron1_Weight2 ... Neuron1_WeightN
% Neuron2_Weight1 Neuron2_Weight2 ... Neuron2_WeightN
% ...
% NeuronM_Weight1 NeuronM_Weight2 ... NeuronM_WeightN
%
% It is important that this format is maintained as it is what
% lab_vis(...) expects.
%
% Some points that you need to consider are:
%   - How should you randomise the weight matrix at the start?
%   - How do you decay both the learning rate and radius over time?
%   - How does updating the weights of a neuron effect those nearby?
%   - How do you calculate the distance of two neurons when they are
%     arranged on a single line?

% get number of example and dimension
sample_num = size(trainingData,1);
dimensions = size(trainingData,2);

% sample initialization, where the weight vectors are initialized with random samples drawn from the input data set
%som = rand(neuronCount, dimensions);
som = datasample(trainingData, neuronCount);
% t is the current iteration
t = 0;

% initialise learning_rate and radius
learning_rate=startLearningRate;
radius=startRadius;

% initialise tau1 and tau2
tau1 = trainingSteps;
tau2 = trainingSteps / log(startRadius);

% do iteration (trainingSteps times)
while t < trainingSteps
    % Randomly pick an input vector
    x_n = trainingData(randi(sample_num) , :);
    
    % Get the winner (closest) neuron
    diffs = bsxfun(@minus, x_n, som);
    % First,Get the Euclidean distances between input vector and all neurons
    distances = mag(diffs);
    [min_distance, winner_index] = min(distances);
    
    % find neighbor neuron
    right = min(neuronCount, floor(winner_index + radius));
    left = max(1, ceil(winner_index - radius));
    
    % update the weights of the winner and its neighbors
    for k = left : right
        
       %the city-block distance between neighbor neuron and winner neuron
       distance = abs(k - winner_index);
       
       % neighborhood Kernel function.
       h = exp( -(distance ^ 2) / (2 * radius ^ 2) );
       
       % Update weights of the winner neuron and its neighbors.
       som(k, :) = som(k, :) + learning_rate * h * (x_n - som(k, :));
    end
    
    % decrease the learning rate
    learning_rate = startLearningRate * exp(-t/tau1);  
    % decreasethe neighborhood size (radius ie, sigma(t))
    radius= startRadius * exp(-t/tau2); 
    
    % next iteration
    t = t + 1;
end
end