function r = Domination(a,b)
    r = sum((a.obj-b.obj)<=0) == length(a.obj);
end