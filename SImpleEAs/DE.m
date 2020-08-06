function [bestf,bestx] = DE(maxGen,NP,D,lower,upper,pi)
    F = 0.5;
    Cr = 0.5;
    X = lower+rand(NP,D).*(upper-lower);
    bestf = zeros(1,maxGen);
    bestx = zeros(NP,D);
    for gen=1:maxGen
        V = mutation(X,F);
        U = cossover(X,V,Cr);
        U = repair(U,lower,upper);
        [X,objs] = selection(X,U,pi);
        [minf,mini]=min(objs);
        bestf(gen) = minf;
        bestx(gen,:) = X(mini);
    end
end

function X = mutation(X,F)
    NP = size(X,1);
    r = zeros(NP,3);
    for i = 1:NP
        r(i,:) = randperm(NP,3);
    end
    X = X(r(:,1),:) + F.*(X(r(:,2),:)-X(r(:,3),:));
end

function V = repair(V,lower,upper)
    V(V<lower) = min(upper,2*lower - V(V<lower));
    V(V>upper) = max(lower,2*upper - V(V>upper));
end

function U = cossover(X,V,Cr)
    [NP,D] = size(X);
    index = rand(NP,D)<Cr;
    for i=1:NP
        ri = randi(D);
        index(i,ri) = 1;
    end
    U = V.*index + X.*(1-index);
end

function [X,objs] = selection(X,U,pi)
    X = X.*(f(X,pi)<f(U,pi))+U.*(f(U,pi)<f(X,pi));
    objs = f(X,pi);
end

function objs = f(X,index)
    n = size(X,2);      % dimension of x
    switch(index)
        case 1
            objs = sum(X.^2, 2);
        case 2
            objs = sum(abs(X), 2) + prod(abs(X), 2);
        case 3
            objs = sum(cumsum(X,2).^2, 2);
        case 4
            objs = max(abs(X),[], 2);
        case 5
            objs = sum(100*(X(:,2:n)-X(:,1:n-1).^2).^2 ...
                + (X(:,1:n-1)-1).^2, 2);
        case 6
            objs = sum(floor(X+0.5).^2 ,2);
        case 7
            objs = sum((X.^4) .* (1:n), 2);
            objs = objs + rand(size(objs));
        case 8
            %                     y = -sum(x.*sin(sqrt(abs(x))), 2);
            objs = sum(-sin(sqrt(abs(X))).*X, 2);
        case 9
            objs = sum(X.^2 - 10*cos(2*pi*X) + 10 ,2);
        case 10
            objs = -20*exp(-0.2*sqrt(mean(X.^2, 2))) - ...
                exp(mean(cos(2*pi*X),2)) + 20 + exp(1);
        case 11
            objs = 1/4000 * sum(X.^2 ,2) - ...
                prod(cos(X./sqrt(1:n)),2) + 1;
        case 12
            Y = 1+0.25*(X+1);
            u = obj.get_u2(X,10,100,4);
            objs = pi/n*( 10*sin(pi*Y(:,1)).^2 +...
                sum((Y(:,1:n-1)-1).^2 .*...
                (1+10*sin(pi*Y(:,2:n)).^2),2) +...
                (Y(:,n)-1).^2) +...
                sum(u,2);
        case 13
            u = obj.get_u2(X,5,100,4);
            objs = 0.1 * (sin(3*pi*X(:,1)).^2 ...
                + sum( ((X(:,1:n-1)-1).^2) .* ...
                (1+sin(3*pi*X(:,2:n)).^2), 2) ...
                + (X(:,n)-1).^2) ...
                + sum(u,2);
        case 14
            y1 = 10.^(6/(n-1).*(0:n-1));
            objs = sum((X.^2) .* y1, 2);
        case 15
            objs = X(:,1).^2 + 10^6 * sum(X(:,2:n).^2,2);
        case 16
            objs = 10^6 * X(:,1).^2 + sum(X(:,2:n).^2,2);
        case 17
            objs = 0;
            a = 0.5; b = 3;
            for i=1:n
                for k=0:20
                    objs = objs + a^k*cos(2*pi*b^k*(X(i)+0.5));
                end
            end
            sum2 = 0;
            for k=0:20
                sum2 = sum2 + a^k*cos(2*pi*b^k*0.5);
            end
            objs = objs - n*sum2;
    end
end

