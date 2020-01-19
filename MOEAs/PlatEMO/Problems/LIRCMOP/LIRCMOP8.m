classdef LIRCMOP8 < PROBLEM
% <problem> <LIR-CMOP>
% Constrained benchmark MOP with large infeasible regions

%------------------------------- Reference --------------------------------
% Z. Fan, W. Li, X. Cai, H. Huang, Y. Fang, Y. You, J. Mo, C. Wei, and E.
% Goodman, An improved epsilon constraint-handling method in MOEA/D for
% CMOPs with large infeasible regions, Soft Computing, 2019.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

% This function is written by Wenji Li
    
    methods
        %% Initialization
        function obj = LIRCMOP8()
            obj.Global.M = 2;
            if isempty(obj.Global.D)
                obj.Global.D = 30;
            end
            obj.Global.lower    = zeros(1,obj.Global.D);
            obj.Global.upper    = ones(1,obj.Global.D);
            obj.Global.encoding = 'real';
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,X)
            variable_length = size(X,2);
            popsize         = size(X,1);
            sum1            = zeros(popsize,1);
            sum2            = zeros(popsize,1);
            for j=2:variable_length
                if mod(j,2)==1
                    sum1=sum1+(X(:,j)-sin((0.5*j/variable_length*pi)*X(:,1))).^2;
                else
                    sum2=sum2+(X(:,j)-cos((0.5*j/variable_length*pi)*X(:,1))).^2;
                end
            end
            gx             = 0.7057;
            
            PopObj(:,1) = X(:,1)+10*sum1+gx;
            PopObj(:,2) = 1-X(:,1).^2+10.*sum2+gx;
        end
        %% Calculate constraint violations
        function PopCon = CalCon(obj,X)
            PopObj = obj.CalObj(X);
            p      = [1.2,2.25,3.5];
            q      = [1.2,2.25,3.5];
            a      = [2,2.5,2.5];
            b      = [6,12,10];
            r      = 0.1;
            theta  = -0.25*pi;
            for k=1:3
                PopCon(:,k)= r - ((PopObj(:,1)-p(k))*cos(theta)-(PopObj(:,2)-q(k))*sin(theta)).^2/(a(k)^2) -...
                    ((PopObj(:,1)-p(k))*sin(theta)+(PopObj(:,2)-q(k))*cos(theta)).^2/(b(k)^2);
            end
        end
        %% Sample reference points on Pareto front
        function P = PF(obj,N)
            P(:,1) = (0:1/(N-1):1)';
            P(:,2) = 1 - sqrt(P(:,1));
            P      = P + 0.7057;
            theta  = -0.25*pi;
            c1     = 0.1 - ((P(:,1)-1.2)*cos(theta)-(P(:,2)-1.2)*sin(theta)).^2/(2^2) -...
                     ((P(:,1)-1.2)*sin(theta)+(P(:,2)-1.2)*cos(theta)).^2/(6^2);
            invalid = c1>0;
            while any(invalid)
                P(invalid,:) = (P(invalid,:)-0.7057).*1.001 + 0.7057;
                c1 = 0.1 - ((P(:,1)-1.2)*cos(theta)-(P(:,2)-1.2)*sin(theta)).^2/(2^2) -...
                     ((P(:,1)-1.2)*sin(theta)+(P(:,2)-1.2)*cos(theta)).^2/(6^2);
                invalid = c1>0;
            end
        end 
    end
end