function MatingPool = MatingSelection(BiObj)
% The mating selection of ABOEA

    N = size(BiObj,1);
    
    %% Binary tournament selection
    Parents1   = randi(N,1,N);
    Parents2   = randi(N,1,N);
    Dominate   = any(BiObj(Parents1,:)<BiObj(Parents2,:),2) - any(BiObj(Parents1,:)>BiObj(Parents2,:),2);
    MatingPool = [Parents1(Dominate>=0),...
                  Parents2(Dominate<0)];
end