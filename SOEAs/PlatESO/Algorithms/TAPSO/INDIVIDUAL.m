classdef INDIVIDUAL < handle
    %INDIVIDUAL �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    
    properties
        dec;
        obj;
    end
    
    methods
        function obj = INDIVIDUAL(Decs,pi)
            %INDIVIDUAL ��������ʵ��
            %   �˴���ʾ��ϸ˵��
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

