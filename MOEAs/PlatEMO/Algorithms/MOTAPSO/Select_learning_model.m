function [P,V] = Select_learning_model(P,V,E,PB,GB,i,w)
%SELECT_LEARNING_MODEL �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    if Domination(E(i),GB)
        V(i,:) = w * V(i,:) + rand(1,size(P(1).dec,2)) .* (E(i).dec - P(i).dec);
    elseif Domination(E(i),PB(i))
        V(i,:) = w * V(i,:) + rand(1,size(P(1).dec,2)) .* (E(i).dec - P(i).dec) + rand(1,size(P(1).dec,2)) .* (GB.dec - P(i).dec);
    else
        V(i,:) = w * V(i,:) + rand(1,size(P(1).dec,2)) .* (PB(i).dec - P(i).dec);
    end
    P(i) = INDIVIDUAL(P(i).dec + V(i,:));
end

