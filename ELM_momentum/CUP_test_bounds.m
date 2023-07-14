clear variables
load('..\utility\import_CUP.mat')

path = '..\utility\initial_weights\weights-reg.mat';
load(path)

% Add loaded weights
w = init (10, 150, 2);
w(1).weight = weight_matrix;

% Parameters
j_max = 60000;
lambda = 1e-2;
act = "sigmoid";

% Generate H and add regularization
[H]  = feedforward (w, dataset, act);
H = [H; lambda*eye(size(H,2))];

% Add padding to target
target = [dataset_target; zeros(size(H,2), size(dataset_target,2))];

% Randomly generate lr and momentum within bounds using approximations of L
% and tau
G = H'*H;
L = norm(G, "fro");
num_lr = 5; % Number of learning rate to be generated (for each initialization)
l_bound = 1/L;
u_bound = 4/L;
random_values = l_bound+(u_bound-l_bound)*rand(1, num_lr-3);
lr_values = [l_bound, random_values, u_bound];
momentum_values = [0.2, 0.6, 0.8, 0.9, 0.95];

% Find best set of randomly generated parameters
grid_table = cell2table(cell(0, 6), 'VariableNames', {'lr', 'momentum', 'gap_pred', 'gap_sol', 'iter', 'index'});
index=0;
for lr = lr_values
    for momentum = momentum_values

        % Display parameters
        disp("---")
        disp(lr)
        disp(momentum)
        tic
        % Parameters: (weights, input, target, accuracy, j_max, activation_hidden,lambda, lr, alpha, return_hist)
        [w_new, j, history] = train (w, dataset, dataset_target, 1e-10, j_max, act, lambda, lr, momentum, false);
        toc

        % Compute gaps
        gap_pred = compute_gap("relative_gap_pred", target, H, w_new(2).weight)
        gap_sol = compute_gap("relative_gap_sol", target, H, w_new(2).weight)

        if (~isnan(gap_pred))
            index=index+1;
            row_grid = {lr, momentum, gap_pred, gap_sol, j, index};
            grid_table = [grid_table; row_grid];
        end
    end
end

grid_table = sortrows(grid_table, "gap_sol") % Orders the results