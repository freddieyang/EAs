function MatingPool = MatingSelection(PopObj,FrontNo,N)
%MATINGSELECTION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵�� 
    
    [~,M]  = size(PopObj);
    W = UniformPoint(N,M);

    cosine = 1 - pdist2(PopObj,W,'cosine');
    
    Angle  = acos(cosine);
    tmp = sort(Angle,2);
%     AD = tmp(:,2)./tmp(:,1);

    AD = max(tmp(:,1:M),[],2)./mean(tmp(:,1:M),2);
    
    MatingPool = TournamentSelection(2,N,FrontNo,AD);
end

