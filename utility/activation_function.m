function [z] = activation_function (func, z)
% Applies a chosen activation function to a vector
% Inputs:
%       func     type of activation function, the possible activation
%                functions are: "identity", "sigmoid", "relu", "leaky",
%                "tanh".
%       z        vector to which the activation function is going to be
%                applied
%
% Output:
%       z        vector after activation function was applied
%
%  Authors: Martina Melero Cavallo, Alberto Roberto Marinelli

switch func
    case "identity"
    case "sigmoid"
        z = exp(-z);
        z = 1+z;
        z = 1./z;
    case "relu"
        z = max(0, z);
    case "leaky"
        if z<0
            z = 0.01*z;
        end
    case "tanh"
        z = tanh(z);
end