function PB = Reuse_exemplars(Ao,PB)
%REUSE_EXEMPLARS 此处显示有关此函数的摘要
%   此处显示详细说明
    [~,PBi] = sort(PB.objs,'descend');
    if mod(length(Ao),2)==1
        Ao = setdiff(Ao,Ao(randperm(length(Ao),1)),'rows');
    end
    group1 = randperm(length(Ao),floor(length(Ao)/2));
    group2 = setdiff(1:length(Ao),group1);
    for i = 1:floor(length(Ao)/2)
        if Ao(group1(i)).obj < Ao(group2(i)).obj
            E = Ao(group1(i));
        else
            E = Ao(group2(i));
        end
        if E.obj < PB(PBi(i)).obj
            PB(PBi(i)) = E;
       end
    end
end

