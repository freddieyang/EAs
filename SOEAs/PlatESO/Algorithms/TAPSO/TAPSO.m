clear
clc

global initial_flag
pi = 1;
MaxFEs = 5000;


%% Initialization
initial_flag = 0;
N = 20;
D = 10;
t = 0;
pc = 0.5;
pm = 0.02;
Ao = [];
M = N/4;
w = 0.7298; 
% ir = zeros(1,M);

V = zeros(N,D);
[~,upper,lower] = benchmark_func(zeros(1,D),pi);
P = lower + (upper-lower) * rand(N,D);
P = INDIVIDUAL(P,pi);
PB = P;
Pp = P;
[~,GBI] = min(P.objs);
GB = P(GBI);
%% experiment module
fave = zeros(MaxFEs,1);
fbest = zeros(MaxFEs,1);
%%
while t < MaxFEs
    t = t + 1;
    if t == 1
        [~,AeI] = sort(P.objs);
        Ae = P(AeI(1:M));
        ir = Ir(P,Pp);
        [ir,ApI] = sort(ir,'descend');
        Ap = P(ApI(1:M));
        ir = ir(1:M);
    else
        Ae = [Ae, P];
        [~,I,~] = unique(Ae.decs, 'row');
        Ae = Ae(I);
        [~,AeI] = sort(Ae.objs);
        Ae = Ae(AeI(1:M));

%         Ap = [Ap,P];
%         ir = [ir,Ir(P,Pp)];
%         [ir,ApI] = sort(ir,'descend');
%         Ap = Ap(ApI(1:M));
%         ir = ir(1:M);
        % 更换Ap更新方式效果变好
        ir = Ir(P,Pp);
       
        [ir,ApI] = sort(ir,'descend');
        Ap = P(ApI(1:M));
        ir = ir(1:M);
    end
    
    Pp = P;
    pk = (M:-1:1)/sum(M:-1:1);
    E(1,length(P)) = INDIVIDUAL;
    for i = 1:N
        E(i) = INDIVIDUAL(Breed_Exemplar(Ae,Ap,pm,pc,pk,upper,lower),pi);
        [P,V] = Select_learning_model(P,V,E,PB,GB,i,w,pi);
        if length(Ao)<N && E(i).obj<PB(i).obj
            Ao = [Ao;E(i)];
            
        elseif length(Ao) >= N && E(i).obj<PB(i).obj
            ri = randperm(length(Ao),2);
            if Ao(ri(1)).obj > Ao(ri(2)).obj
                Ao(ri(1)) = E(i);
            else
                Ao(ri(2)) = E(i);
            end
        end
        if P(i).obj < PB(i).obj
            PB(i) = P(i);
        end
    end
    PB = Reuse_exemplars(Ao,PB);
    [~,GBI] = min(P.objs);
    GB = P(GBI);
    fave(t) = mean(P.objs);
    fbest(t) = min(P.objs);
    disp(t);
    disp(mean(P.objs));
end

plot(1:MaxFEs,fbest)
% plot(X)

function ir =  Ir(X,Xp)
    ir = ((Xp.objs - X.objs)./(exp(sqrt(sum((Xp.decs - X.decs).^2,2)))))';
end