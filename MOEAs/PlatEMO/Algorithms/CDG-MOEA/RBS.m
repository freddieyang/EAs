function [P] = RBS(Q,G,K,Global)
%RBS Algorithm 5: Rank-based Selection
%   Input : Q: the combined population. 
%   Output: A population P.
    Rx = zeros(length(Q),Global.M);
    S = Q.objs;
    for i = 1:Global.M
        for j=1:K
            G(i,:) = j;
        end
        [~,Rx(:,i)]=sort(S(:,i));
    end
    [~,index] = sortrows(sort(Rx,2));
    P = Q(index(1:Global.N));
end

