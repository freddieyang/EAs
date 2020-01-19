function CDGMOEA(Global)
% <algorithm> <C>
% K --- 180 --- The number of the intervals on each objective
% delta --- 0.9 --- Delta
% T --- 5 --- The grid neighborhood distance
% Idea --- 2 --- The no. of idea

    %% Parameter definition
    m = Global.M;
    K = Global.ParameterSet(180);
    delta = 0.9;
    T = 5;
%     Idea = 1;
    %% Step 1: Initialization:
    Population = Global.Initialization();
%     [~,FrontNo,CrowdDis] = EnvironmentalSelection(Population,Global.N);
    z_star = Update1(Population);
%     if Idea == 1
        z_nad = Update2(Population,z_star,1./zeros(1,m));
%     end
%     if Idea == 2
%         z_nad = max(Population.objs);
%     end
%     z_nad = Update2(Population,z_star,1./zeros(1,m));
    G = GS(Population,z_star,z_nad,m,K);
    gen= 0;
    time_in = 0;
    time_out = 0;
    %% Step 2: Reproduction:
    while Global.NotTermination(Population)
        Q = INDIVIDUAL;
        for i = 1:length(Population)
%             if rand<delta && abs(length(GN(Population(i),T,Population,G,Global)))>2
            % 局部变异，更改成精英
            NS=[];
            if rand<delta
                NS = GN(Population(i),T,Population,G,Global);
            end
            if length(NS)<2
                NS = Population;
            end
%             end
            parents = randperm(length(NS));
            % 写成自己的
            Q = [Q,DE(Population(i),NS(parents(1)),NS(parents(2)))];
            
        end
        Q = Q(2:end);
        %% Step 3: Update of the ideal and nadir points: 
        gen = gen+1;
        Population = [Population,Q];
        z_star = Update1(Population);
%         if Idea == 1
%             z_nad = Update2(Population,z_star,z_nad);
%         else
%             if Idea == 2
                if mod(gen,50)==0
                    z_nad = Update2(Population,z_star,z_nad);
%                     z_nad = max(Population.objs);
                end
%             end
%         end
        %% Step 4: Update of the grid system:
        P_bar = Population(sum(Population.objs>z_nad,2)>=1);
        Population =  setdiff(Population,P_bar);
        G = GS(Population,z_star,z_nad,m,K);
        %% Step 5: Rank-based selection:
        if length(Population)<Global.N
            rsi = randperm(length(P_bar));
            % 工作，怎么选
            Population = [Population,P_bar(rsi(1:Global.N-length(Population)))];
            % 统计次数
%             time_in = time_in+1
        else
%             Population = RBS(Population,G,K,Global);
            Population = RBS_xu(Population,G,Global.N);
%             time_out = time_out+1
        end
        G = GS(Population,z_star,z_nad,m,K);
    end
end