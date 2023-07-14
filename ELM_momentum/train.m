function [weights, j, history] = train (weights, input, target, threshold, j_max, activation_hidden, lambda, lr, alpha, return_hist)
% Trains an ELM using Standard Momentum 
% Inputs:
%       weights             initial weights for the network
%       input               dataset to train on
%       target              array of target values
%       threshold           threshold for the loss used as stopping
%                           criterion
%       j_max               maximum number of iterations used ad stopping
%                           criterion
%       activation_hidden   activation function used in the hidden layer
%       lambda              regularization coefficient
%       lr                  learning rate
%       alpha               momentum coefficient
%       return_hist         boolean value, if true return history of 
%                           'relative_gap_pred' for each epoch
%
% Outputs:
%       weights             weights after training
%       j                   reached number of iterations
%       history             array of loss values for each epoch
%
%  Authors: Martina Melero Cavallo, Alberto Roberto Marinelli

if ~exist('return_hist', 'var')
        return_hist=false;
end

j=1;
history=[];

% Compute hidden layer output matrix and add regularization
[H]  = feedforward (weights, input, activation_hidden);
H = [H; lambda*eye(size(H,2))];

% Add padding to target
target = [target; zeros(size(H,2), size(target,2))];
target = H'*target;
H = H'*H;

% Initialize output weight matrix
B = weights(2).weight;
B_old = 0;

% Compute gradient to set relative threshold
grad = H*B - target; 
threshold = threshold*norm(grad); % Relative stopping condition

if (return_hist)
    history(end+1) = compute_gap("relative_gap_sol", target, H, B);
end

while j<j_max && norm(grad)>threshold
    
    grad = H*B - target; 
    weights(2).weight = B;

    % Update output weight matrix
    B = B - grad*lr + alpha*(B-B_old);
    B_old = weights(2).weight;

    j = j+1;
    
    if (return_hist)
        history(end+1) = compute_gap("relative_gap_sol", target, H, B);
    end
end

% Save output weight matrix
weights(2).weight = B;