function DCDAS(Global)
% <algorithm> <A>

    %% Parameter setting
    M = Global.M;
    N = Global.N;
    S = ones(M,1);
    %% Generate random population
    Population = Global.Initialization();
    [~,FrontNo,CrowdDis] = EnvironmentalSelection(Population,Global.N,S.*0.5);
    entp = get_Entropy(Population);
    %% Optimization
    while Global.NotTermination(Population)
        MatingPool = TournamentSelection(2,Global.N,FrontNo,-CrowdDis);
        Offspring  = GA(Population(MatingPool));
        ent = get_Entropy(Population);
        delta_ent = ent - entp
        entp = ent/log(N*M);
%         dist = Distribution(FrontNo,N);
        S = 0.5 - delta_ent;
        [Population,FrontNo,CrowdDis] = EnvironmentalSelection([Population,Offspring],Global.N,S*ones(1,N));
    end
end

