function [som,grid] = lab_som2d (trainingData, neuronCountW, neuronCountH, trainingSteps, startLearningRate, startRadius)
% som = lab_som2d (trainingData, neuronCountW, neuronCountH, trainingSteps, startLearningRate, startRadius)
% -- Purpose: Trains a 2D SOM, which consists of a grid of
%             (neuronCountH * neuronCountW) neurons.
%             
% -- <trainingData> data to train the SOM with
% -- <som> returns the neuron weights after training
% -- <grid> returns the location of the neurons in the grid
% -- <neuronCountW> number of neurons along width
% -- <neuronCountH> number of neurons along height
% -- <trainingSteps> number of training steps 
% -- <startLearningRate> initial learning rate
% -- <startRadius> initial radius used to specify the initial neighbourhood size
%

% TODO:
% The student will need to copy their code from lab_som() and
% update it so that it uses a 2D grid of neurons, rather than a 
% 1D line of neurons.
% 
% Your function will still return the a weight matrix 'som' with
% the same format as described in lab_som().
%
% However, it will additionally return a vector 'grid' that will
% state where each neuron is located in the 2D SOM grid. 
% 
% grid(n, :) contains the grid location of neuron 'n'
%
% For example, if grid = [[1,1];[1,2];[2,1];[2,2]] then:
% 
%   - som(1,:) are the weights for the neuron at position x=1,y=1 in the grid
%   - som(2,:) are the weights for the neuron at position x=2,y=1 in the grid
%   - som(3,:) are the weights for the neuron at position x=1,y=2 in the grid 
%   - som(4,:) are the weights for the neuron at position x=2,y=2 in the grid
%
% It is important to return the grid in the correct format so that
% lab_vis2d() can render the SOM correctly

% get the number of examples and number of dimensions
sample_num = size(trainingData,1);
dimensions = size(trainingData,2);

radius=startRadius;
learning_rate=startLearningRate;
neuron_num = neuronCountH * neuronCountW;

% sample initialization, 
% where the weight vectors are initialized with random samples drawn from the input data set
som = datasample(trainingData, neuron_num);

% grid initialization
grid = zeros(neuron_num, 2);
n = 1;
% initialise grid
for y = 1 : neuronCountW
     for x = 1 : neuronCountH
         grid(n, :) = [x, y];  
         % process the som weight 
         %som(n, :) = [x / neuronCountH, y / neuronCountW];
         n = n + 1;
     end
end

t = 1;
% initialise tau1 and tau2
tau1 = trainingSteps;
tau2 = trainingSteps / log(startRadius);

% begin iteration
while t <= trainingSteps
    % Get random sample from traning data.
    x_n = trainingData(randi(sample_num) , :);
    
    % caculate the distances from input vector to all neurons.
    diffs = bsxfun(@minus, x_n, som);
    distances = mag(diffs);
    
    % Get the winner neuron (find min distance)
    [min_distane, min_ix] = min(distances);
    min_pos = grid(min_ix, :);
    
    % find neighbors
    % Judge the size of neighborhood(radius)
    if radius > 1.0
        % for every neuron
        for k = 1 : neuron_num
            % get the postion of neuron(call it nk)
            curr_position = grid(k, :);
            % get the distance between neuron(nk) and winner neuron
            distance = eucdist(min_pos, curr_position);
            
            % judge whether the neuron(nk) in the radius
            % if the neuron(nk) in the neighborhood(radius)
            if distance <= radius
                % Neighborhood Kernel function.
                h = exp( -(distance ^ 2) / (2 * radius ^ 2) );
                % Update weights of the neuron.
                som(k, :) = som(k, :) + learning_rate * h * (x_n - som(k, :));
            end
        end
    else
        k = min_ix;
        % do same thing as above
        curr_position = grid(k, :);
        distance = eucdist(min_pos, curr_position);
        if distance <= radius
            % neighborhood Kernel function.
            h = exp( -(distance ^ 2) / (2 * radius ^ 2) );
            % Update weights.
            som(k, :) = som(k, :) + learning_rate * h * (x_n - som(k, :));
        end
    end
    % decrease the learning rate
    learning_rate = startLearningRate * exp(-t / tau1);  
    % decrease the neighborhood size (radius)
    radius= startRadius * exp(-t / tau2); 
    
    % next iteration
    t = t + 1;
end
% final result
%som = w;
end
