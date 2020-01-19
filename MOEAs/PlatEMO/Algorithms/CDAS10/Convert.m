function [nobjs] = Convert(objs,S)
%CONVERT �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    [n,m] = size(objs);
    index = diag(ones(1,m));
    nobjs = [];
    for i = 1:m
        omega = atan(sqrt(sum(reshape(objs(0 == repmat(index(i,:),n,1)),n,m - 1).^2,2))./objs(1 == repmat(index(i,:),n,1)));
        nobjs = [nobjs,sqrt(sum(objs.^2,2)).*(sin(omega + S(i)*pi)/sin(S(i)*pi))];
    end
end

