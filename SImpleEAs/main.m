maxGen = 10000;
NP = 100;
D = 15;
lower = -10;
upper = 10;
pi = 6;

[bestf,bestx] = DE(maxGen,NP,D,lower,upper,pi);

disp(bestf);
% disp(bestx);

plot(1:length(bestf),bestf)
