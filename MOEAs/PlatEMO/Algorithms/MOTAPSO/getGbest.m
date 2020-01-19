function Gbest = getGbest(Gbest,Population,Global)
%GETGBEST 此处显示有关此函数的摘要
%   此处显示详细说明
    Population = [Population,Gbest];
    NDS = Population(NDSort(Population.objs,1) == 1);
    Gbest = NDS(randi(length(NDS),1,Global.N));
end

