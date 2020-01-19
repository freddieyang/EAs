function transformed = CT(original,m,angle)
%CT Coordinate Transformation
%   
    transformed = zeros(length(original),m);
    if m == 2
        OObjs = original.objs;
        transform_metrix = [cos(-angle),sin(-angle);-sin(-angle),cos(-angle)];
        for i = 1:length(original)
            transformed(i,:) = transform_metrix * OObjs(i,:)';
        end
    elseif m == 3
        
    end
end

