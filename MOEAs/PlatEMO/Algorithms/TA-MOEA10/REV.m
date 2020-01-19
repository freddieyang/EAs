function NP = REV(P,Pb)
%REV 此处显示有关此函数的摘要
%   此处显示详细说明
%     best = round(1 + (length(Pb)-1).*rand(1,length(P)));
%     a = randperm(length(P),length(P));
%     b = randperm(length(P),length(P));
%     b(a == b) = randperm(length(P),sum(a==b));
%     NP = INDIVIDUAL(P.decs + 0.5*(Pb(best).decs - P.decs)+0.5*(P(a).decs-P(b).decs));
%     Pobjs = P.objs;
%     Pbobjs = Pb.objs;
    neighbour = zeros(length(Pb),length(P));
    for i = 1:length(Pb)
        neighbour(i,:) = sum((P.objs-Pb(i).objs).^2,2)';
    end
    [~, min_index] = min(neighbour);
    NP = INDIVIDUAL(P.decs + 2 * rand * (Pb(min_index).decs - P.decs));
end

