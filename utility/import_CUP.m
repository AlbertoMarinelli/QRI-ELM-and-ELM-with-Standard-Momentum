% Loads the CUP dataset and targets into arrays
%
%  Authors: Martina Melero Cavallo, Alberto Roberto Marinelli

dataset = readtable("ML-CUP21-TR.csv");

dataset_target = removevars(dataset, {'Var1', 'Var2', 'Var3', 'Var4', 'Var5', 'Var6', 'Var7', 'Var8', 'Var9', 'Var10', 'Var11'});
dataset = removevars(dataset, {'Var1', 'Var12', 'Var13'});

dataset_target = table2array(dataset_target);
dataset = table2array(dataset);