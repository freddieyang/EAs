classdef MMF3 < PROBLEM
% <problem> <MMF>  
    
    methods
        %% Initialization
        function obj = MMF3()
            obj.Global.M = 2;
            obj.Global.D = 2;
            obj.Global.lower    = [0,0];
            obj.Global.upper    = [1,1.5];
            obj.Global.encoding = 'real';
        end
        
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            PopObj(:,1) = PopDec(:,1);
            PopDec(PopDec(:,2)>0.5 & PopDec(:,2)<1 & PopDec(:,1)>=0 & PopDec(:,1)<0.25,2) = PopDec(PopDec(:,2)>0.5 & PopDec(:,2)<1 & PopDec(:,1)>=0 & PopDec(:,1)<0.25,2)-0.5;             
            PopDec(PopDec(:,2)>=1 & PopDec(:,2)<=1.5,2) = PopDec(PopDec(:,2)>=1 & PopDec(:,2)<=1.5,2)-0.5; 
            g = PopDec(:,2)-PopDec(:,1).^0.5;
            PopObj(:,2) = 1 - PopDec(:,1).^0.5 + 2*(4*g.^2 - 2*cos(20*g*pi./2.^0.5)+2);        
        end
        %% Sample reference points on Pareto front
        function P = PF(obj,N)
            P(:,1) = (0:1/(N-1):1);
            P(:,2) = 1 - P(:,1).^0.5;
        end
    end
end

