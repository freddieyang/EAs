classdef SYM_PART_rotated < PROBLEM
% <problem> <MMF>    

    methods
        %% Initialization
        function obj = SYM_PART_rotated()
            obj.Global.M = 2;
            obj.Global.D = 2;
            obj.Global.lower    = [-20,-20];
            obj.Global.upper    = [20,20];
            obj.Global.encoding = 'real';
        end

        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            a = 1;
            b = 10;
            c = 8;
            w = pi/4;
            r1 = cos(w).*PopDec(:,1) - sin(w).*PopDec(:,2);
            r2 = sin(w).*PopDec(:,1) + cos(w).*PopDec(:,2);
            temp_t1 = sign(r1) .* ceil((abs(r1) - (a+c/2))/(2*a+c));
            temp_t2 = sign(r2) .* ceil((abs(r2) - b/2)/b);            
            t1 = sign(temp_t1) .* min(abs(temp_t1),1);
            t2 = sign(temp_t2) .* min(abs(temp_t2),1);
            p1 = PopDec(:,1) - t1*(c+2*a);
            p2 = PopDec(:,2) - t2*b;
            PopObj(:,1) = (p1 + a).^2 + p2.^2;
            PopObj(:,2) = (p1 - a).^2 + p2.^2;
        end
        %% Sample reference points on Pareto front
        function P = PF(obj,N)
            a = 1;
            v = rand(1);
            P(:,1) = 4 * a.^2 * v.^2;
            P(:,2) = 4 * a.^2 * (1-v).^2;
        end
    end
end

