% Test on classification (MONK dataset)
w = init (17, 75, 1);

[weights, iter, hist] = train (w, training, tr_target, 1e-3, 10000, "sigmoid", 1e-3, 7e-4, 0.002, true);

mat = feedforward(weights,training,"sigmoid");
y2= predict(training, weights, "sigmoid");
accuracy(y2, tr_target, 0.5)

% Test on regression (f(x) = 2x)
w = init (1,10,1);
tic
[w_trained] = train (w, [1;2;3;4;5;6;7;8;9;10], [2;4;6;8;10;12;14;16;18;20], 1e-4, 1000, "relu", 1e-5, 4e-3, 0, true);
toc
y = predict ([1;2;3;4;5;6;7;8;9;10], w_trained, "relu")