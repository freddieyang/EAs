classdef INDIVIDUAL < handle
    %INDIVIDUAL 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        dec;
        obj;
    end
    
    methods
        function obj = INDIVIDUAL(Decs,pi)
            %INDIVIDUAL 构造此类的实例
            %   此处显示详细说明
            if nargin > 0
               obj(1,size(Decs,1)) = INDIVIDUAL;
               for i = 1 : length(obj)
                    obj(i).dec = Decs(i,:);
                    obj(i).obj = f(Decs(i,:),pi);
               end
            end
        end
        function value = decs(obj)
            value = cat(1,obj.dec);
        end
        function value = objs(obj)
            value = cat(1,obj.obj);
        end
    end
end

