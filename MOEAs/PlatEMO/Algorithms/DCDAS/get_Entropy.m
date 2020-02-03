function ent = get_Entropy(Population)
%GET_ENTROPY �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    objs = Population.objs;
    [K,M] = size(objs);
    z_star = Update1(objs);
    z_nad = Update2(objs);
    C = ceil(K*(objs - z_star)./(z_nad - z_star));
    ent = 0;
    for m = 1:M
        for k = 1:K
            cell = sum(ismember(C(:,m),k));
            p = cell/(K*M);
            if p~=0
                ent = -ent+p*log(p);
            end
        end
    end
end



