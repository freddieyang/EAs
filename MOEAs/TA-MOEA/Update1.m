function Pe = Update1(P,Global,Pe,NE)
%UPDATE1` 此处显示有关此函数的摘要
%   此处显示详细说明
    [~,index] = min(P.objs);
    Pe = [Pe,P(index)];
    len = Global.N/5;
    if length(Pe)>NE
        Pe = EnvironmentalSelection(Pe,NE);
    end
end