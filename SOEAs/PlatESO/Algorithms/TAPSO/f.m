function [y,upper,lower] = f(X,index)
%F 此处显示有关此函数的摘要
%   此处显示详细说明
    if index == 1
        bias = 0;
        y = sum(X.^2 + bias,2);
        upper = 100;
        lower = -100;
    elseif index == 2
        
    end
end