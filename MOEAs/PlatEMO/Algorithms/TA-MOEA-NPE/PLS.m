function Pl = PLS(Pb,alpha,Global)
%PLS 此处显示有关此函数的摘要
%   此处显示详细说明
    lower = min(Pb.decs,[],1);
    upper = max(Pb.decs,[],1);
    [~,~,CrowdDis] = EnvironmentalSelection(Pb,length(Pb));
    [row,col] = size(Pb.decs);
    index = CrowdDis<mean(setdiff(rmmissing(CrowdDis),Inf));
    if sum(index)~=0
        try
            NP = INDIVIDUAL(rand*(upper + lower) - Pb(index).decs);
        catch
            disp(123);
        end
    end
    m = (lower + (upper-lower).*rand([row,col])).*randsrc(row,col,[-1,1])*alpha;
    diff = m(0==index,:);
    if sum(index)~=0
        Pl = [INDIVIDUAL(Pb(0==index).decs+diff),NP];
    else
        Pl = INDIVIDUAL(Pb.decs+diff);
    end
end

