function [Population,FrontNo] = EnvironmentalSelection(Population,N,zmin,zmax)
% The environmental selection of NSGA-II

%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

%    % Normalization
%     PopObj = Population.objs - repmat(zmin,length(Population),1);
%     range  = zmax - zmin;
%     if 0.05*max(range) < min(range)
%         PopObj = PopObj./repmat(range,length(Population),1);
%     end
%     [~,x]      = unique(roundn(PopObj,-6),'rows');
%     PopObj     = PopObj(x,:);
%     Population = Population(x);
%     N          = min(N,length(Population));

    PopObj = Population.objs;
    PopObj = (PopObj - min(PopObj))./(max(PopObj) - min(PopObj));
    %% Non-dominated sorting
%     [FrontNo,MaxFNo] = NDSort(Population.objs,Population.cons,N);
    [FrontNo,MaxFNo] = CDR_Sort(PopObj,N);
    Next = FrontNo < MaxFNo;
    
    %% Calculate the crowding distance of each solution
    CrowdDis = CrowdingDistance(Population.objs,FrontNo);
    [~,M]  = size(PopObj);
    W = UniformPoint(N,M);

    cosine = 1 - pdist2(PopObj,W,'cosine');
    
    Angle  = acos(cosine);
    tmp = sort(Angle,2);
    AD = max(tmp(:,1:M),[],2)./mean(tmp(:,1:M),2);

    %% Select the solutions in the last front based on their crowding distances
    Last     = find(FrontNo==MaxFNo);
    [~,Rank] = sort(AD(Last));
    Next(Last(Rank(1:N-sum(Next)))) = true;
    
    %% Population for next generation
    Population = Population(Next);
    FrontNo    = FrontNo(Next);
end