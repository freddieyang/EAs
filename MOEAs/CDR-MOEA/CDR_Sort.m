function [FrontNo,MaxFNo] = CDR_Sort(PopObj,nSort)
% Sorting by convergence dominance relation (CDR)

    N = size(PopObj,1);
    omega = PopObj./sum(PopObj,2);
    omega(omega == 0) = 1e-6;
    
    NormP = max((PopObj-min(PopObj,[],1))./omega,[],2);
    
    cosine = 1 - pdist2(PopObj,PopObj,'cosine');
    cosine(logical(eye(length(cosine)))) = 0;
    Angle  = acos(cosine);

    temp  = sort(unique(min(Angle,[],2)));
    minA  = temp(min(ceil(N/2),end));
    Theta = max(1,(Angle./minA).^1);

    dominate = false(N);
    for i = 1 : N-1
        for j = i+1 : N
            if NormP(i)*Theta(i,j) < NormP(j)
                dominate(i,j) = true;
            elseif NormP(j)*Theta(j,i) < NormP(i)
                dominate(j,i) = true;
            end
        end
    end

    FrontNo = inf(1,N);
    MaxFNo  = 0;
    while sum(FrontNo~=inf) < min(nSort,N)
        MaxFNo  = MaxFNo + 1;
        current = ~any(dominate,1) & FrontNo==inf;
        FrontNo(current)    = MaxFNo;
        dominate(current,:) = false;
    end
end