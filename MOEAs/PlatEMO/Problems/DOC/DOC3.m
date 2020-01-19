classdef DOC3 < PROBLEM
% <problem> <DOC>
% Benchmark MOP with constraints in both decision and objective spaces

%------------------------------- Reference --------------------------------
% Z. Liu and Y. Wang, Handling constrained multiobjective optimization
% problems with constraints in both the decision and objective spaces. IEEE
% Transactions on Evolutionary Computation, 2019.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    methods
        %% Initialization
        function obj = DOC3()
            obj.Global.M = 2;
            obj.Global.D = 10;
            obj.Global.lower    = [0 0 0 0 0 0 0 0 0 0.01];
            obj.Global.upper    = [1 1 300 100 200 100 1 100 200 0.03];
            obj.Global.encoding = 'real';
        end
        %% Calculate objective values
        function PopObj = CalObj(~,X)
             g_temp = -9.* X(:, 6) - 15.* X(:, 9) + 6.* X(:, 2) + 16.* X(:, 3) + 10.* (X(:, 7) + X(:, 8));
             g = (g_temp+400.0551) +1;
             PopObj(:,1) = X(:,1);
             PopObj(:,2) = g.*(1 - (PopObj(:,1))./g);
            
        end
        %% Calculate constraint violations
        function PopCon = CalCon(obj,X)
            PopObj = obj.CalObj(X);
           % constraints in objective space
           c(:,1) =max( -(PopObj(:,1).^2 + PopObj(:,2).^2-1), 0);
           c(:,2) = max(-( abs( (-PopObj(:,1) + PopObj(:,2) -0.5)/sqrt(2)) - 0.1/sqrt(2)), 0);
           c(:,3) = max(-( abs( (-PopObj(:,1) + PopObj(:,2) -0)/sqrt(2)) - 0.1/sqrt(2)), 0);
           c(:,4) = max(-( abs( (-PopObj(:,1) + PopObj(:,2) +0.5)/sqrt(2)) - 0.1/sqrt(2)), 0);
    
           % constraints in decision space
           c(:, 5) = X(:, 10).* X(:, 4) + 0.02.* X(:, 7) - 0.025.* X(:, 6);
           c(:, 6) = X(:, 10).* X(:, 5) + 0.02.* X(:, 8) - 0.015.* X(:, 9);
           c(:, 7) = abs(X(:, 2) + X(:, 3) - X(:, 4) - X(:, 5)) - 0.0001;
           c(:, 8) = abs(0.03.* X(:, 2) + 0.01.* X(:, 3) - X(:, 10).* (X(:, 4) + X(:, 5))) - 0.0001;
           c(:, 9) = abs(X(:, 4) + X(:, 7) - X(:, 6)) - 0.0001;
           c(:, 10) = abs(X(:, 5) + X(:, 8) - X(:, 9)) - 0.0001;
           PopCon=c;
        end
        %% Sample reference points on Pareto front
        function P = PF(obj,N)
            P = UniformPoint(N,2);
            P = P./repmat(sqrt(sum(P.^2,2)),1,2);
            P(0.3403<P(:,1) & P(:,1)<0.4782 | 0.6553<P(:,1) & P(:,1)<0.7553 | 0.8782<P(:,1) & P(:,1)<0.9403,:) = [];
        end
    end
end