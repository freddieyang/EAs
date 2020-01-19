function Z = ZS(Objs,K)
%ZS 此处显示有关此函数的摘要
%   此处显示详细说明
    sigma = 1e-11;
    Objs = Objs(:,2);
    d = (max(Objs)-min(Objs)+2*sigma)/K;
    Z = ceil((Objs-min(Objs)+sigma)./d);
end

