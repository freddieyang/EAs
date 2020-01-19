function [Population,Ao,Pbest,V] = Operator(Population,V,Ae,Ao,Ap,Gbest,Pbest,pm,pc,w,M,Global)
%OPERATOR 此处显示有关此函数的摘要
%   此处显示详细说明
    pk = (M:-1:1)/sum(M:-1:1);
    E(1,length(Population)) = INDIVIDUAL;
    for i = 1:Global.N
        E(i) = INDIVIDUAL(Breed_Exemplar(Ae,Ap,pm,pc,pk,Global));
        [Population,V] = Select_learning_model(Population,V,E,Pbest,Gbest(i),i,w);
        if length(Ao)<length(Population) && Domination(E(i),Pbest(i))
            Ao = [Ao,E(i)];
        elseif length(Ao) >= length(Population) && Domination(E(i),Pbest(i))
            ri = randperm(length(Ao),2);
            if Domination(Ao(ri(2)), Ao(ri(1)))
                Ao(ri(1)) = E(i);
            else
                Ao(ri(2)) = E(i);
            end
        end
        if Domination(Population(i),Pbest(i))
            Pbest(i) = Population(i);
        end
    end
end

