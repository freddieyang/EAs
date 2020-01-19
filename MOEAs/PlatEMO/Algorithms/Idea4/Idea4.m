function Idea4(Global)
% <algorithm> <A>
% S --- 0.5 --- The parameter of angle
    %% Parameter setting
    S = Global.ParameterSet(0.5);
    
    p = 0.5;
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
        S = 0.46 + (0.54-0.46)*S * Global.evaluated/Global.evaluation;
        [Population,FrontNo,CrowdDis] = EnvironmentalSelection([Population,Offspring],Global.N,S);
    end
end

