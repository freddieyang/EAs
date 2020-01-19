function TAMOEANPE(Global)
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
    Pb = INDIVIDUAL;
    s = 0;
    while Global.NotTermination(P)
        try
            alpha = 1 - Global.evaluated/Global.evaluation;
            p = Global.evaluated/Global.evaluation;
            Pb = Update2(P,Global,Pb,NB);
            if s == 0
                Pb = Pb(2:end);
                s = 1;
            end
            Pb = unique(Pb);
            if rand<p
                NP = PLS(Pb,alpha,Global);
            else
    %             NP = REV(P,Pb);
                NP = GA(P);
            end
            P = EnvironmentalSelection([P,NP],Global.N);
        catch
            disp(123);
        end
    end
end