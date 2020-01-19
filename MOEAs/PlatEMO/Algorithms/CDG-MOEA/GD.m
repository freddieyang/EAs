function [distance] = GD(u,v,Population,G)
%Grid Distance
%   Input : u, v: two solutions. 
%   Output: grid distance between u and v. 
    distance = max(abs(G(Population==u,:)-G(Population==v,:)));
end
