function [acc] = accuracy (y_pred, y_true, threshold)
% Computes accuracy on binary values after thresholding
% Inputs:
%       y_pred             array of predictions
%       y_true             array of targets
%       threshold          threshold to set predictions to either 0 or 1
%
% Outputs:
%       acc             accuracy of predictions
%
%  Authors: Martina Melero Cavallo, Alberto Roberto Marinelli

    y_pred(y_pred < threshold) = 0;
    y_pred(y_pred >= threshold) = 1;
    
    y = y_true-y_pred;
    acc = sum(y == 0,"all")/size(y,1);

end      