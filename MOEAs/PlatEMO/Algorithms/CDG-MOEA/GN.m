function [x_star] = GN(x,T,Population,G,Global)
%Grid Neighbor
%   Input : x: a solution. 
%   T: Distance
%   x_star:  The grid neighbors of a solution x within distance T.
%     x_star = INDIVIDUAL;
%     for i = 1:Global.N
%         if find(Population==x) ~= i
%             if GD(x,Population(i),Population,G)<=T
%                 x_star = [x_star,Population(i)];
%             end
%         end
%     end
%     
%     x_star = x_star(2:end);
    x_star = setdiff(Population(max(abs(G-G(Population==x,:)),[],2)<=T),x);
end