function E = Breed_Exemplar(Ae,Ap,pm,pc,pk,Global)
%BREED_EXEMPLAR �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    lower = Global.lower;
    upper = Global.upper;
    [M,D] = size(Ae.decs);
    r = rand(1,D);
    dec_Ae = Ae.decs;
    dec_Ap = Ap.decs;
    Xp1 = diag(dec_Ae(randsample(1:M,D,1,pk),1:D))';
    Xp2 = diag(dec_Ap(randsample(1:M,D,1,pk),1:D))';
    E = Xp2.*(r<pc)+Xp1.*(r>=pc);
    r = rand(1,D);
    tmp = lower + (upper-lower) .* rand(1,D);
    E(r<pm) =tmp(r<pm);
end

