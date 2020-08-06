function [Population,z,znad] = EnvironmentalSelection(Population,N,z,znad,lambda)
% The environmental selection of ABOEA

    PopObj = Population.objs;
%     [PopObj,z,znad] = Normalization(PopObj,z,znad);
    
    %% Non-dominated sorting wrt the actual objectives
    [FrontNo,MaxFNo] = NDSort(PopObj,N);
    Next = FrontNo < MaxFNo;
    
    %% Convergence and diversity degree estimation for the last-front solutions of the actual objectives
    Last  = find(FrontNo==MaxFNo);
    BiObj = Estimation(PopObj(Last,:),lambda);
    
    %% Non-dominated sorting wrt the bi-criteria
    [FrontNo2,MaxFNo2] = NDSort(BiObj,N-sum(Next));
    Next(Last(FrontNo2<MaxFNo2)) = true;

    %% Select the solutions in the last front
    Last2 = Last(FrontNo2==MaxFNo2);
    Next(Last2(randperm(length(Last2),N-sum(Next)))) = true;
    % Population for next generation
    Population = Population(Next);
end