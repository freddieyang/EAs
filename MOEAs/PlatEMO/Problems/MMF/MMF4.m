classdef MMF4 < PROBLEM
% <problem> <MMF>  
    
    methods
        %% Initialization
        function obj = MMF4()
            obj.Global.M = 2;
            obj.Global.D = 2;
            obj.Global.lower    = [-1,0];
            obj.Global.upper    = [1,2];
            obj.Global.encoding = 'real';
        end
        
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            PopObj(:,1) = abs(PopDec(:,1));
            PopDec(PopDec(:,2)>=1 & PopDec(:,2)<=2,2) = PopDec(PopDec(:,2)>=1 & PopDec(:,2)<=2,2)-1; 
            PopObj(:,2) = 1 - PopDec(:,1).^2 + 2*(PopDec(:,2) - sin(pi*PopObj(:,1))).^2;        
        end
        %% Sample reference points on Pareto front
        function P = PF(obj,N)
            P(:,1) = (0:1/(N-1):1);
            P(:,2) = 1 - P(:,1).^2;
        end
    end
end

