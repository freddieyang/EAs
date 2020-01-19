% function entropy = get_Entropy(Population)
% % GET_ENTROPY 此处显示有关此函数的摘要
% %   此处显示详细说明
%     entropy = 0;
%     objs = Population.objs;
%     [K,M] = size(objs);
%     f_min = min(objs);
%     f_max = max(objs);
%     C = floor(K*(objs - f_min)./(f_max - f_min));
%     entropy = zeros(1,M);
%     for m = 1:M
%         ent = 0;
%         for k = 1:K
%             cell = sum(ismember(C(:,m),k));
%             p = cell/(K);
%             if p~=0
%                 ent = ent+p*log(p);
%             end
%         end
%         entropy(m) = -ent;
%     end
%     entropy = entropy/log(K);
% end

function entropy = get_Entropy(Population)
%GET_ENTROPY 此处显示有关此函数的摘要
%   此处显示详细说明
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
                ent = ent+p*log(p);
            end
        end
    end
    entropy = -ent/log(K*M);
end



