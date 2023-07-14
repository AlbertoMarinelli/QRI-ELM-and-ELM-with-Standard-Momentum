function [weights, B, R, H, u_matrix, k, history] = train_random_gen (weights, input, target, threshold, k_max, activation_hidden, lambda, return_hist)
% Trains a QRI-ELM generating weights randomly at each iteration
% Inputs:
%       weights             initial weights for the network
%       input               dataset to train on
%       target              array of target values
%       threshold           threshold for the loss used as stopping
%                           criterion
%       k_max               maximum number of neurons used ad stopping
%                           criterion
%       activation_hidden   activation function used in the hidden layer
%       lambda              regularization coefficient
%       return_hist         boolean value, if true return history of 
%                           'relative_gap_pred' for each epoch
%
% Outputs:
%       weights             weights after training
%       B                   output weights
%       R                   'R' matrix of QR factorization
%       H                   hidden layer output matrix
%       u_matrix            matrix of 'u' arrays to compute Householder
%                           reflectors
%       k                   number of neurons at the end of train
%       history             array of loss values for each epoch
%
%  Authors: Martina Melero Cavallo, Alberto Roberto Marinelli

k = 1;
history = [];

% Compute matrix to factor and the Householder vectors
[H]  = feedforward (weights, input, activation_hidden);
[u_matrix, R] = householder_vector([H; lambda*eye(k)]);

% Add padding to target
target = [target; zeros(1, size(target,2))];

% Compute output weight matrix
c = target - 2*u_matrix*(u_matrix'*target);
B = R\c(k); 

% Restore target to original size
target(end,:) = [];

gap = compute_gap ("relative_gap_pred", target, H, B);

if (return_hist)
    history(end+1) = gap;
end

while k<k_max && gap>threshold

    % Add new randomly generated column of weights
    w_new = 0.05*rand(size(input, 2)+1, 1);
    weights(1).weight = [weights(1).weight w_new];
    k = k+1;

    [H]  = feedforward (weights, input, activation_hidden);

    % Compute new "u" vector to compute Householder reflector and new
    % column for the R matrix
    I = eye(k);
    [u, r_new] = qr_step([H(:,end); lambda*I(:,k)], u_matrix, k);
    
    u_matrix(:,k)=[u];
   
    R = [[R; zeros(1,size(R,2))], r_new];

    % Compute output weight matrix
    c = [c; zeros(1, size(c,2))];
    c(k:end, :) = c(k:end, :) - 2*u_matrix(:,k)*(u_matrix(:,k)'*c(k:end, :));

    B = R\c(1:k,:);

    gap = compute_gap ("relative_gap_pred", target, H, B)

    if (return_hist)
        history(end+1) = gap;
    end
end