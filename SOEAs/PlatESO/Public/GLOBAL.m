classdef GLOBAL < handle
    %GLOBAL 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties(SetAccess = ?PROBLEM)
        M;                              % Number of objectives
        D;                              % Number of decision variables
        lower;                          % Lower bound of each decision variable
        upper;                          % Upper bound of each decision variable
        encoding   = 'real';            % Encoding of the problem
        evaluation = 10000;             % Maximum number of evaluations
    end
    properties(SetAccess = ?INDIVIDUAL)
        evaluated  = 0;                 % Number of evaluated individuals
    end
    properties(SetAccess = private)
        algorithm  = @NSGAII;       	% Algorithm function
        problem    = @DTLZ2;            % Problem function
        gen;                            % Current generation
        maxgen;                         % Maximum generation
        run        = 1;                 % Run number
        runtime    = 0;                 % Runtime
        save       = 0;             	% Number of saved populations
        result     = {};                % Set of saved populations
        PF;                             % True Pareto front
        parameter  = struct();      	% Parameters of functions specified by users
        outputFcn  = @GLOBAL.Output;  	% Function invoked after each generation
    end
    methods
        %% Constructor
        function obj = GLOBAL(varargin)
            %GLOBAL 构造此类的实例
            %   此处显示详细说明
        end
        function Population = Initialization(obj,N)
            Population = INDIVIDUAL(obj.problem.Init(N));
        end
    end
end

