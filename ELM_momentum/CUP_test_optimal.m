clear variables
load('..\utility\import_CUP.mat')

path = '..\utility\initial_weights\weights-reg.mat';
load(path)

w = init (10, 150, 2);
w(1).weight = weight_matrix;

% Parameters
j_max = 60000;
lambda = 1e-2;
return_hist = true;
act = "sigmoid";

% Generate H and add regularization
[H]  = feedforward (w, dataset, act);
H = [H; lambda*eye(size(H,2))];

% Add padding to target
target = [dataset_target; zeros(size(H,2), size(dataset_target,2))];


% Compute lr and momentum from formulas using optimal values
G = H'*H;
[lr, momentum, L, tau] = optimal_values(G)

disp("Starting training!")
tic
% Parameters: (weights, input, target, accuracy, j_max, activation_hidden,lambda, lr, alpha, return_hist)
[w_new, iter, history] = train (w, dataset, dataset_target, 1e-10, j_max, act, lambda, lr, momentum, return_hist);
toc

% Reached number of iterations
iter

% Plot gap for each iteration and theoretical bound
if (return_hist)
    % ELM convergence
    pts.x = [1:size(history,2)];
    pts.y = history;
    pts.legend=strcat('Optimal lambda=',num2str(lambda));

    % Theoretical convergence
    pts0.x = [1:size(history,2)-1];
    e = [];
    % Compute rate of convergence
    r = (sqrt(L)-sqrt(tau))/(sqrt(L)+sqrt(tau));
    e = history(1);
    for i = 2:size(history,2)-1
        e = [e, (r^i)*history(1)];
    end
    pts0.y = e;
    pts0.legend ='Theory';
    plot_learning_curve([pts, pts0])
    
end

gap_pred = compute_gap("relative_gap_pred", target, H, w_new(2).weight)
gap_sol = compute_gap("relative_gap_sol", target, H, w_new(2).weight)