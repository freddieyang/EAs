classdef MMF7< PROBLEM
% <problem> <MMF>  
    
    methods
        %% Initialization
        function obj = MMF7()
            obj.Global.M = 2;
            obj.Global.D = 2;
            obj.Global.lower    = [1,-1];
            obj.Global.upper    = [3,1];
            obj.Global.encoding = 'real';
        end
        
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            PopObj(:,1) = abs(PopDec(:,1)-2);
            PopObj(:,2) = 1 - PopObj(:,1).^0.5 + (PopDec(:,2)-(0.3*PopObj(:,1).^2.*cos(24*pi*PopObj(:,1)+4*pi)+0.6*PopObj(:,1)).*sin(6*pi*PopObj(:,1)+pi)).^2;        
        end
        %% Sample reference points on Pareto front
        function P = PF(obj,N)
            P(:,1) = (0:1/(N-1):1);
            P(:,2) = 1 - P(:,1).^0.5;
        end
    end
end

