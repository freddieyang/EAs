function Offspring = GenerateOffspring(Population,Z,K)
%GENERATEOFFSPRING generate the offspring
%   此处显示详细说明
    N = length(Population);
    Offspring = ones(N,length(Population(1).dec));
    for i = 1:N
        ZN = (Z - Z(i))<=1;
        if sum(ZN) >= 2
            parents = randperm(length(ZN),2);
        else
            parents = randperm(N);
        end
        Offspring(i,:) = DE(Population(i).dec,Population(parents(1)).dec,Population(parents(2)).dec);
    end
    Offspring = INDIVIDUAL(Offspring);
end

