function [weights, seed] = init(input, hidden, output, init_seed)
% Generate initial structure of weights
% Inputs:
%       input               number of input features
%       hidden              number of hidden neurons
%       output              number of output neurons
%       init_seed           optional random initialization seed
%
% Outputs:
%       weights             structure of weights
%       seed                seed used during the initialization of weights
%
%  Authors: Martina Melero Cavallo, Alberto Roberto Marinelli 

    if ~exist('init_seed','var')
     % if init_seed is not given
        rng('shuffle') % Generate random seed
    else
      % else initializate to init_seed the random function
        rng(init_seed);
    end
    
    seed = rng;
    l_boud = -0.7;
    u_boud = +0.7;
    weights(1).weight = l_boud+(u_boud-l_boud)*rand(input+1, hidden);
    weights(2).weight = l_boud+(u_boud-l_boud)*rand(hidden, output); 