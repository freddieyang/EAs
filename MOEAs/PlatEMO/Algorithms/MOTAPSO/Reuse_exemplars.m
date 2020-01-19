function PB = Reuse_exemplars(Ao,PB)
%REUSE_EXEMPLARS 此处显示有关此函数的摘要
%   此处显示详细说明
    tmp_PB = EnvironmentalSelection(PB,length(PB));
    [~,PBi] = ismember(tmp_PB,PB);
    if mod(length(Ao),2)==1
        Ao = setdiff(Ao,Ao(randperm(length(Ao),1)));
    end
    group1 = randperm(length(Ao),floor(length(Ao)/2));
    group2 = setdiff(1:length(Ao),group1);
    for i = 1:floor(length(Ao)/2)
        if Domination(Ao(group1(i)),Ao(group2(i)))
            E = Ao(group1(i));
        else
            E = Ao(group2(i));
        end
        if Domination(E,PB(PBi(i)))
            PB(PBi(i)) = E;
       end
    end
end

