function [lr, momentum, L, tau] = optimal_values (H)
% Given a matrix, outputs the learning rate and momentum coefficient
% computed with formulas from the theory of Standard Momentum using its
% eigenvalues
% Inputs:
%       H               input matrix
%
% Outputs:
%       lr              optimal learning rate value
%       momentum        optimal momentum coefficient value
%       L               largest eigenvalue
%       tau             smallest eigenvalue
%
%  Authors: Martina Melero Cavallo, Alberto Roberto Marinelli   

    eig_vector = eig(H);

    % Tau is the smallest eigenvalue
    tau = eig_vector(1);
    % L is the largest eigenvalue
    L = eig_vector(end);
    
    lr = 4/(sqrt(L) + sqrt(tau))^2;
    momentum = max(1 - sqrt(lr * tau), 1 - sqrt(lr * L))^2;

end