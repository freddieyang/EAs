function TAMOEANA(Global)
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
    s = 0;
    while Global.NotTermination(P)
        try
            alpha = 1 - Global.evaluated/Global.evaluation;
            p = Global.evaluated/Global.evaluation;
            if s == 0
                s = 1;
            end
    %         Pl = [PLS([Pb,Pp],alpha,Global),Pb,Pp];
    %             NP = REV(P,Pb);
            NP = GA(P);
            P = EnvironmentalSelection([P,NP],Global.N);
        catch
        end
    end
end