function [u, a_new] = qr_step(A, u_matrix, k)
% Given a matrix to factor (A), a matrix containing the u-vectors of
% the Householder reflectors of the columns of A and the number of hidden 
% neurons, produces a new column for the R matrix in the QR factorization 
% and a vector (u) to compute the new Householder vector
% Inputs:
%       A                   matrix to factor
%       u_matrix            matrix used to compute the Householder vectors
%       k                   number of neurons
%
% Outputs:
%       u                   vector to compute the new Householder vector
%       a_new               new column for the R matrix of the QR
%                           factorization
%
%  Authors: Martina Melero Cavallo, Alberto Roberto Marinelli

    for j=1:size(u_matrix,2)
        u = [u_matrix(:,j); zeros(k-j,1)];
        A(j:end) = A(j:end) - 2*u*(u'*A(j:end));
    end

    [u, s] = householder_vector(A(k:end));
    
    a_new = [A(1:k-1); s];
end