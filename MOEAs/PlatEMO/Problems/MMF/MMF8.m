classdef MMF8 < PROBLEM
% <problem> <MMF>  
    
    methods
        %% Initialization
        function obj = MMF8()
            obj.Global.M = 2;
            obj.Global.D = 2;
            obj.Global.lower    = [-pi,0];
            obj.Global.upper    = [pi,9];
            obj.Global.encoding = 'real';
        end
        
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            PopObj(:,1) = sin(abs(PopDec(:,1)));
            PopDec(PopDec(:,2)>4 & PopDec(:,2)<=9,2) = PopDec(PopDec(:,2)>4 & PopDec(:,2)<=9,2)-4; 
            PopObj(:,2) = (1 - PopObj(:,1).^2).^0.5 + 2*(PopDec(:,2) - PopObj(:,1) - abs(PopDec(:,1))).^2;        
        end
        %% Sample reference points on Pareto front
        function P = PF(obj,N)
            P(:,1) = (0:1/(N-1):1);
            P(:,2) = (1 - P(:,1)).^2;
        end
    end
end

