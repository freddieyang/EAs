function Gbest = getGbest(Gbest,Population,Global)
%GETGBEST �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    Population = [Population,Gbest];
    NDS = Population(NDSort(Population.objs,1) == 1);
    Gbest = NDS(randi(length(NDS),1,Global.N));
end

