function dist = Distribution(FrontNo,N)
%GET_DISTRIBUTION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    maxF = max(FrontNo);
    dist = zeros(1,maxF);
    for i = 1:maxF
        dist(i) = sum(FrontNo == i)/N;
    end
end

