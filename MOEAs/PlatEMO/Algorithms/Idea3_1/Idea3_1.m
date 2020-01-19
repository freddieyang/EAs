function Idea3_1(Global)
% <algorithm> <A>
% angle --- 45 --- transform anble
% K --- 100 --- zone number

    %% Parameter setting
    [angle,K] = Global.ParameterSet(45,100);
    %% Initialization
    m = Global.M;
    N = Global.N;
    angle = angle/180*pi;
    Population = Global.Initialization();
    TObjs = CT(Population,m,angle);
    Z = ZS(TObjs, K);
    %% Optimization
    while Global.NotTermination(Population)
        Offspring = GenerateOffspring(Population,Z,K);
        TObjs = CT([Population,Offspring],m,angle);
        Z = ZS(TObjs,K);
        Population = ZSA([Population,Offspring],TObjs,Z,Global);
%         Population = EnvironmentalSelection([Population,Offspring],Global.N);
        TObjs = CT(Population,m,angle);
        Z = ZS(TObjs,K);
    end
end