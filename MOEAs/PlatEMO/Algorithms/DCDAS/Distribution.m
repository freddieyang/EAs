function dist = Distribution(FrontNo,N)
%GET_DISTRIBUTION 此处显示有关此函数的摘要
%   此处显示详细说明
    maxF = max(FrontNo);
    dist = zeros(1,maxF);
    for i = 1:maxF
        dist(i) = sum(FrontNo == i)/N;
    end
end

