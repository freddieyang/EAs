function ir =  Ir(P,Pp)
    ir = mean(sum((Pp.objs - P.objs).^2,2))./(exp(sum((Pp.decs - P.decs).^2,2)));
end