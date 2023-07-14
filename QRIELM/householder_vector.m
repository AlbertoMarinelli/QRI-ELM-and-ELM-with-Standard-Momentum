function [u, s] = householder_vector(x)
% Given an input vector, generates "u" such that H = I-2uu' is an
% Householder reflector
% Inputs:
%       x                 input vector
%
% Outputs:
%       u                 vector used for computing the Householder
%                         reflector
%       s                 +/- norm of the input vector
%
%  Authors: Martina Melero Cavallo, Alberto Roberto Marinelli
s = norm(x);
% To avoid numerical problems
if x(1) >= 0
    s = -s;
end
v = x;
v(1) = v(1) - s;
u = v / norm(v); 
% satisfies H*x = s*e1