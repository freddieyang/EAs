function [G] = GS(P,z_star,z_nad,~,K)
%GS Algorithm 1: Grid-system Setup
%   Input : P: the current population; 
%   z_star: the approximation of the ideal point; 
%   z_nad: the approximation of the nadir point; 
%   m: the number of 
%   K: the number of the intervals on each
    sigma = 1e-11;
    d = (z_nad-z_star+2*sigma)/K;         
%     G = zeros(length(P), m);
%     for i = 1:length(P)
%        for j = 1:m
%            G(i,j) = ceil(((P(i).obj(j) - z_star(j) + sigma)) /d(j));
%        end
%     end
    G = ceil((P.objs-z_star+sigma)./d);
end

