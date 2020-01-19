function NewPopulation = ZSA(Population,TObjs,Z,Global)
%ZSA 此处显示有关此函数的摘要
%   此处显示详细说明
    tmpObjs = TObjs(:,end);
    NewPopulation = INDIVIDUAL;
    AZ = unique(Z);
    for i = 1:length(AZ)
        NewPopulation = [NewPopulation,Population(min(tmpObjs(AZ(i) == Z)) == tmpObjs)];
    end
    NewPopulation = NewPopulation(2:end);
    if length(NewPopulation)<Global.N
        disp(length(NewPopulation));
        leftPopulation = setdiff(Population,NewPopulation);
        NewPopulation = [NewPopulation,Population(randperm(length(leftPopulation),Global.N - length(NewPopulation)))];
%         NewPopulation = [NewPopulation,EnvironmentalSelection(leftPopulation,Global.N - length(NewPopulation))];
    end
end

