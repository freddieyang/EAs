classdef Omni_test < PROBLEM
% <problem> <MMF>  
    
    methods
        %% Initialization
        function obj = Omni_test()
            obj.Global.M = 2;
            if isempty(obj.Global.D)
                obj.Global.D = 3;
            end
            obj.Global.lower    = zeros(1,obj.Global.D);
            obj.Global.upper    = zeros(1,obj.Global.D)+6;
            obj.Global.encoding = 'real';
        end
        
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            PopObj(:,1) = sum(sin(pi*(PopDec(:,1:end))),2);
            PopObj(:,2) = sum(cos(pi*(PopDec(:,1:end))),2);        
        end
        %% Sample reference points on Pareto front
        function P = PF(obj,N)
            n = obj.Global.D;
            P(:,1) = (-n:1/(N-1):0);
            P(:,2) = -(n.^2 - P(:,1).^2).^0.5;
        end
    end
end

