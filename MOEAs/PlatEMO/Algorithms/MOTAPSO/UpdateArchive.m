function [Ae,Ap] = UpdateArchive(Ae,Population,Population_p,M)
%UPDATEARCHIVE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    Ae = EnvironmentalSelection([Population,Ae],M);
    [~,ApI] = sort(Ir(Population,Population_p),'descend');
    Ap = Population(ApI(1:M));
end

