function [y] = predict (input, weights, activation_function) 
% Given an input produces the predicted output
% Inputs:
%       input                 dataset to predict the outputs of
%       weights               weights of the network
%       activation_function   activation function used in the hidden layer
%
% Output:
%       y                   predicted output
%
%  Authors: Martina Melero Cavallo, Alberto Roberto Marinelli
    [H] = feedforward(weights, input, activation_function);
    y=H*weights(2).weight;
    
end