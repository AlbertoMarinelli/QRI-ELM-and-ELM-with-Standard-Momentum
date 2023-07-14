function [weights] = init(input, output)
% Generate initial structure of weights with just one neuron in the hidden
% layer
% Inputs:
%       input               number of input features
%       output              number of output neurons
%
% Outputs:
%       weights             structure of weights
%
%  Authors: Martina Melero Cavallo, Alberto Roberto Marinelli 
    l_boud = -0.7;
    u_boud = +0.7;
    weights(1).weight = l_boud+(u_boud-l_boud)*rand(input+1, 1);
    weights(2).weight = l_boud+(u_boud-l_boud)*rand(2, output);