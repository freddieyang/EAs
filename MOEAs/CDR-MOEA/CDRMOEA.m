function CDRMOEA(Global)
% <algorithm> <A>
% 
    
    %% Generate random population
    Population = Global.Initialization();
    zmin       = min(Population.objs,[],1);
    FrontNo = CDR_Sort(Population.objs,Global.N);
    
    %% Optimization
    while Global.NotTermination(Population)
        MatingPool = MatingSelection(Population.objs,FrontNo,Global.N);
        Offspring  = GA(Population(MatingPool));
        zmin       = min([zmin;Offspring.objs],[],1);
        zmax       = max(Population(FrontNo==1).objs,[],1);
        [Population,FrontNo] = EnvironmentalSelection([Population,Offspring],Global.N,zmin,zmax);
    end
end