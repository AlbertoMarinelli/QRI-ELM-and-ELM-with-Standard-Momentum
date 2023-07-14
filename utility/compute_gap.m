function [gap] = compute_gap (type, y_true, H, B)
% Computes gaps to evaluate quality of a model
% Inputs:
%       type     type of gap to compute, the possible values are: 
%                "relative_gap_pred", "relative_gap_sol", "abs_gap_sol".
%       y_true   array of target values
%       H        hidden layer output matrix
%       B        output weight matrix
%
% Output:
%       gap     computed gap value
%
%  Authors: Martina Melero Cavallo, Alberto Roberto Marinelli 

    switch type
        case "relative_gap_pred"
            y_pred=H*B; % Compute prediction
            gap = norm(y_pred - y_true)/norm(y_true);
        case "relative_gap_sol" 
            B_opt = H\y_true; % Compute optimal solution
            gap = norm(B-B_opt)/norm(B_opt);
        case "abs_gap_sol" 
            B_opt = H\y_true; % Compute optimal solution
            gap = norm(B-B_opt);
    end
    
end