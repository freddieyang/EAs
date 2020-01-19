function [P] = RBS_xu(Q,G,n)
%RBS 利用网格坐标来排序，再选取前n个组成种群P
%   输入：种群Q、网格坐标矩阵G、保留个体数n
%   输出：保留的种群P
    %% 先对各个子问题的目标排序
    f = Q.objs;         % 目标矩阵
    [nq, m] = size(f);
    R = zeros(nq,m); % 每个个体在各维度的序号
    for i = 1:nq
        for j = 1:m
            % 如果这个子问题以前解决了，就不要重复工作了
            if R(i,j) ~= 0
                continue
            end
            id = true;  % 先假设所有个体都和i属于同一子问题
            % 要找到所有与i属于同一子问题的个体
            for t = 1:m
                if t==j % 忽略当前维度,但其他维度的网格坐标必须相等
                    continue
                end
                id = id & (G(:,t)==G(i,t));
            end
            s = f(id,:);    % 选中所有相同子问题的个体的目标值
%             disp(j)
            [~,I] = sortrows(s,j);    % 按第j个目标排序
            rank = (1:size(s,1));
            rank = rank(I);
            R(id,j) = rank;
        end
    end
    %% 对R进行处理，输出P
    R = sort(R,2);              % 对每行各自排序
    [~,I] = sortrows(R); % 字典排序
    id = I(1:n);
    P = Q(id);
end