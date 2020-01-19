classdef MMF12 < PROBLEM
% <problem> <MMF>
% np ---2--- Total number of global and local PSs.
% q ---4--- The number of discountinuous pieces in each PF(PS).
    properties(Access = private)
        np = 2;
        q = 4;
    end
    methods
        %% Initialization
        function obj = MMF12()
            obj.Global.M = 2;
            obj.Global.D = 2;
            obj.Global.lower    = [0,0];
            obj.Global.upper    = [1,1];
            obj.Global.encoding = 'real';
        end

        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            np = obj.np;
            q = obj.q;
            PopObj(:,1) = PopDec(:,1);
            g = 2 - exp(-2*log10(2) .* (((PopDec(:,2)-0.1)/0.8).^2)) .* (sin(np*pi.*PopDec(:,2)).^6);
            h = 1 - (PopObj(:,1)./g).^2 - PopObj(:,1)./g .* sin(2*pi*q.*PopObj(:,1));
            PopObj(:,2) = g .* h;
        end
 
        %% Sample reference points on Pareto front
        function P = PF(obj,N)  %F ·Ö¶Î
            np = obj.np;
            q = obj.q;
            P(:,1) = (0:1/(N-1):1);
            g = 2 - exp(-2*log10(2) .* ((1/(2*np)-0.1)/0.8).^2) .* (sin(np*pi.*(1/(2*np))).^6);
            h = 1 - (P(:,1)./g).^2 - P(:,1)./g .* sin(2*pi*q.*P(:,1));  
            P(:,2) = g .* h;
        end
    end
end

