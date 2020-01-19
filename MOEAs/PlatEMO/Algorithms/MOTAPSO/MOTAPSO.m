function MOTAPSO(Global)
% <algorithm> <M>
% pc --- 10 --- pc
% pm --- 10 --- pm
% w --- 0.7298 --- w

    %% Parameter Definition
    [pc,pm,w] = Global.ParameterSet(0.5,0.02,0.7098);
    M = Global.N/4;
    V = zeros(Global.N,Global.D);
    Ae = [];
    %% Generate random population
    Population = Global.Initialization();
    [Ae,Ap]    = UpdateArchive(Ae,Population,Population,M);
    Pbest = Population;
    NDS = Population(NDSort(Population.objs,1) == 1);
    Gbest = NDS(randi(length(NDS),1,Global.N));
    Ao = [];
    %% Optimization
    while Global.NotTermination(Population)
        disp(length(Ap));
        Population_p = Population;
        [Population,Ao,Pbest,V] = Operator(Population,V,Ae,Ao,Ap,Gbest,Pbest,pm,pc,w,M,Global);
        Pbest = Reuse_exemplars(Ao,Pbest);
        [Ae,Ap]    = UpdateArchive(Ae,Population,Population_p,M);
        Gbest = getGbest(Gbest,Population,Global);
    end
end