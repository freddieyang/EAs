classdef MMF6 < PROBLEM
% <problem> <MMF>  
    
    methods
        %% Initialization
        function obj = MMF6()
            obj.Global.M = 2;
            obj.Global.D = 2;
            obj.Global.lower    = [1,-1];
            obj.Global.upper    = [3,2];
            obj.Global.encoding = 'real';
        end
        
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            PopObj(:,1) = abs(PopDec(:,1)-2);
            PopDec(PopDec(:,2)>1 & PopDec(:,2)<=2,2) = PopDec(PopDec(:,2)>1 & PopDec(:,2)<=2,2)-1; 
            PopObj(:,2) = 1 - PopObj(:,1).^0.5 + 2*(PopDec(:,2) - sin(6*pi*PopObj(:,1)+pi)).^2;        
        end
        %% Sample reference points on Pareto front
        function P = PF(obj,N)
            P(:,1) = (1:1/(N-1):3);
            P(:,2) = 1 - P(:,1).^0.5;
        end
    end
end

