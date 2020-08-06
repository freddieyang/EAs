function BiObj = Estimation(PopObj,lambda)
    N = size(PopObj,1);

    %% Convergence degree estimation
    omega = PopObj./sum(PopObj,2);
    omega(omega == 0) = 1e-6;
    con = max((PopObj-min(PopObj,[],1))./omega,[],2);
    
    %% Diversity degree estimation
    cosine = 1 - pdist2(PopObj,PopObj,'cosine');
    cosine(logical(eye(length(cosine)))) = 0;
    Angle  = acos(cosine);
    temp  = sort(unique(min(Angle,[],2)));
    
    minA  = temp(min(ceil(lambda * N),end));
    check = Angle < minA;
    sh  = zeros(N);
    conm  = repmat(con,1,N);
    theta = conm./conm';
    sh(check) = (theta(check).*(1-Angle(check)./minA)).^2;
    dis = sqrt(sum(sh,2));
    
    BiObj = [con,dis];
end