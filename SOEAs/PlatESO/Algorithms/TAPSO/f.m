function [y,upper,lower] = f(X,index)
%F �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    if index == 1
        bias = 0;
        y = sum(X.^2 + bias,2);
        upper = 100;
        lower = -100;
    elseif index == 2
        
    end
end