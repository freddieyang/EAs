function [z_star] = Update1(P)
%UPDATE1 Update the Ideal Point 
%   Input : P: the current population. 
%   Output: Updated ideal point z?. 
    z_star = min(P.objs);
end

