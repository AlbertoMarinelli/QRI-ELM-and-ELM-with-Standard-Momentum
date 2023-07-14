training = readtable("data.csv");
tr_target = readtable("data.txt");
tr_target = removevars(tr_target, {'Var2','Var3','Var4','Var5','Var6','Var7','Var8'});
training = table2array(training);
tr_target = table2array(tr_target);
