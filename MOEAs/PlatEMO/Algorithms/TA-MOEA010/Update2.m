function Pb = Update2(P,Global,Pb,NB)
%UPDATE2 此处显示有关此函数的摘要
%   此处显示详细说明
    Pb = [Pb,P(NDSort(P.objs,1) == 1)];
    len = Global.N;
    if length(Pb)>NB
        Pb = EnvironmentalSelection(Pb,NB);
    end
end

