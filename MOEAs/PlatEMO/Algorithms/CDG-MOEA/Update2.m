function [z_nad] = Update2(P,z_star,z_nad)
%UPDATE2 Algorithm 4: Update the Nadir Point 
%   Input : P: the combined population; 
%   z_star: the current ideal point; 
%   z_nad: the current nadir point. 
%   Output: Updated nadir point znad. 
%     SP= INDIVIDUAL;
%     for i = 1: length(P)
%         if sum(P(i).obj < z_star+z_nad/5)>0
%             SP = [SP,P(i)];
%         end
%     end
% %     SP = P(sum(P(i).obj < z_star+z_nad/5)>0)
%     SP = SP(2:end);
    SP =  P(sum(P.objs<repmat(z_star+z_nad/5,length(P),1),2)>0);
    [~,FrontNo,~] = EnvironmentalSelection(SP,length(SP));
    SP = SP(FrontNo == 1);
    z_nad = max(SP.objs);
end

