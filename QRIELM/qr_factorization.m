function [Q, A, u_matrix] = qr_factorization(A)
% Performs a thin-QR factorization of the given matrix
% Inputs:
%       A             matrix to factorize
%
% Outputs:
%       Q             Q matrix
%       A             R matrix
%       u_matrix      matrix of 'u' arrays to compute Householder
%                     reflectors
%
%  Authors: Martina Melero Cavallo, Alberto Roberto Marinelli
[m, n] = size(A);
Q = eye(m,n);

u_matrix = zeros(m,n);
for j = 1:n
    % Compute householder vector
    [u, s] = householder_vector(A(j:end,j));

    % Store u_i in matrix to later compute Q
    u_matrix(j:end, j) = u;

    % Create column for A
    j_column = zeros(m-j+1,1);
    j_column(1) = s;
    % Change A's i-th column
    A(j:m, j) = j_column;

    % Compute A_i to use in next step (step inutile se monocolonna)
    A(j:m, j+1:n) = A(j:m, j+1:n) - 2*u*(u'*A(j:m, j+1:n));
end

% drop rows of zeros
A(n+1:end,:) = [];

% Compute Q
for j = n:-1:1
    u = u_matrix(j:m, j);
    Q(j:m, 1:n) = Q(j:m, 1:n) - 2*u*(u'*Q(j:m, 1:n));
end