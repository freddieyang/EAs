function TAMOEANPB(Global)
% <algorithm> <C>
% NE --- 10 --- The number of divisions in each objective
% NB --- 10 --- The number of divisions in each objective

    %% Parameter definition
    m = Global.M;
    n = Global.N;
    D = Global.D;
    [NB,NE] = Global.ParameterSet(10,10);
    
    %% Step 1 Initialization:
    P = Global.Initialization();
    Pe = INDIVIDUAL;
    s = 0;
    while Global.NotTermination(P)
        alpha = 1 - Global.evaluated/Global.evaluation;
        p = Global.evaluated/Global.evaluation;
        Pe = Update1(P,Global,Pe,NE);
        if s == 0
            Pe = Pe(2:end);
            s = 1;
        end
        Pe = unique(Pe);
        Pe = [Pe,GA(Pe)];
%             NP = REV(P,Pb);
        NP = GA(P);
        P = EnvironmentalSelection([P,NP,Pe],Global.N);
    end
end