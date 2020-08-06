function ABOEA(Global)
% <algorithm> <A>
% Angle-based bi-objective evolutionary algorithm
% lambda --- 1 --- Control the size of niche


    lambda = Global.ParameterSet(1);
    %% Generate random population
    Population = Global.Initialization();
    [z,znad]     = deal(min(Population.objs),max(Population.objs));
    %% Optimization
    while Global.NotTermination(Population)
        MatingPool = MatingSelection(Estimation(Population.objs,lambda));
        Offspring  = GA(Population(MatingPool));
        [Population,z,znad] = EnvironmentalSelection([Population,Offspring],Global.N,z,znad,lambda);
    end
end