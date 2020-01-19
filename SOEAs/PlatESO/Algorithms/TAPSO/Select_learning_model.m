function [X,V] = Select_learning_model(X,V,E,PB,GB,i,w,pi)
%SELECT_LEARNING_MODEL 此处显示有关此函数的摘要
%   此处显示详细说明
    if E(i).obj<GB.obj
        V(i,:) = w * V(i,:) + rand(1,size(X(1).dec,2)) .* (E(i).dec - X(i).dec);
    elseif E(i).obj<PB(i).obj
        V(i,:) = w * V(i,:) + rand(1,size(X(1).dec,2)) .* (E(i).dec - X(i).dec) + rand(1,size(X(1).dec,2)) .* (GB.dec - X(i).dec);
    else
        V(i,:) = w * V(i,:) + rand(1,size(X(1).dec,2)) .* (PB(i).dec - X(i).dec);
    end
    X(i) = INDIVIDUAL(X(i).dec + V(i,:),pi);
end

