% Test on classification (MONK Dataset)
w = init (17,1);
tic                                                    
[w2, B, R, H, u_matrix, k, hist] = train_random_gen (w, training, tr_target, 1e-10, 75, "sigmoid", 0, true);
toc
w2(2).weight = B;
y = predict (training, w2, "sigmoid");
acc = accuracy (y, tr_target, 0.5)

% Test on regression (f(x) = 2x)
w = init (1,2);
tic
[w2, B, R, H, u_matrix, k, hist] = train_random_gen (w, [1;2;3;4;5;6;7;8;9;10], [[2;4;6;8;10;12;14;16;18;20]], 1e-5, 4, "relu", 1e-5, true);
toc
w2(2).weight = B;
y = predict ([1;2;3;4;5;6;7;8;9;10], w2, "relu")
  