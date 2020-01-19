function CDAS06(Global)
% <algorithm> <C>
% S --- 0.5 --- The parameter of angle
    %% Parameter setting
    S = Global.ParameterSet(0.5);

    m = Global.M;
    n = Global.N;
    S = ones(m,1)*S;
    %% Generate random population
    Population = Global.Initialization();
    [~,FrontNo,CrowdDis] = EnvironmentalSelection(Population,Global.N,S);

    %% Optimization
    while Global.NotTermination(Population)
        MatingPool = TournamentSelection(2,Global.N,FrontNo,-CrowdDis);
        Offspring  = GA(Population(MatingPool));
        [Population,FrontNo,CrowdDis] = EnvironmentalSelection([Population,Offspring],Global.N,S);
    end
end

