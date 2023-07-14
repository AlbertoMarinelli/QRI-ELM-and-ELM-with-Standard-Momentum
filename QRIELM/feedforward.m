function [H] = feedforward (weights, input, activation_func) 
% Generate hidden layer output matrix H
% Inputs:
%       weights               network weights
%       input                 input dataset
%       activation_func       activation function used in the hidden layer
%
% Output:
%       H                     hidden layer output matrix
%
%  Authors: Martina Melero Cavallo, Alberto Roberto Marinelli

% For each example
for n=1:size(input,1)
    sample = [1 input(n,:)];
    nets(n).net = sample*weights(1).weight;
    H(n,:) = activation_function(activation_func, nets(n).net);
end

    