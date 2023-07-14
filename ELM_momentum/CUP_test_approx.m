clear variables
load('..\utility\import_CUP.mat')

path = '..\utility\initial_weights\weights-reg.mat';

w = init (10, 150, 2);

% If weight matrix already exists
if (isfile(path))
    % load matrix
    load(path)
    w(1).weight = weight_matrix;
else
    % else save generated one
    weight_matrix = w(1).weight;
    save("weights-reg", "weight_matrix")
end

% Parameters
j_max = 60000;
lambda = 1e-2;
return_hist = false;
act = "sigmoid";

% Generate H and add regularization
[H]  = feedforward (w, dataset, act);
H = [H; lambda*eye(size(H,2))];

% Add padding to target
target = [dataset_target; zeros(size(H,2), size(dataset_target,2))];

% Compute lr and momentum from formulas using approximations of L and tau
G = H'*H;
L = norm(G, "fro");

lr = 4/(sqrt(L) + sqrt(lambda))^2
momentum = max(1 - sqrt(lr * lambda), 1 - sqrt(lr * L))^2

disp("Starting training!")
tic
% Parameters: (weights, input, target, accuracy, j_max, activation_hidden,lambda, lr, alpha, return_hist)
[w_new, iter, history] = train (w, dataset, dataset_target, 1e-10, j_max, act, lambda, lr, momentum, return_hist);
toc

% Reached number of iterations
iter

if (return_hist)
    pts.x = [1:size(history,2)];
    pts.y = history;
    pts.legend=strcat('Approximation lambda=',num2str(lambda));
    plot_learning_curve(pts)
    
end

gap_pred = compute_gap("relative_gap_pred", target, H, w_new(2).weight)
gap_sol = compute_gap("relative_gap_sol", target, H, w_new(2).weight)