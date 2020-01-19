function Offspring = PSO(Particle,Pbest,Gbest,W)
%PSO - Particle swarm optimization operator.
%
%   Off = PSO(P,Pbest,Gbest) returns the offsprings generated by particle
%   swarm optimization, where P is the set of particles to be updated,
%   Pbest is the set of personal best particles, and Gbest is the set of
%   global best particles. P, Pbest, and Gbest MUST BE arrays of INDIVIDUAL
%   objects, and Off is also an array of INDIVIDUAL objects. Each object of
%   P, Pbest, and Gbest is used to generate one offspring.
%
%   Off = PSO(P,Pbest,Gbest,W) specifies the parameter of operator, where W
%   is the inertia weight.
%
%   Example:
%       Off = PSO(Population,Pbest,Gbest)

%------------------------------- Reference --------------------------------
% C. A. Coello Coello and M. S. Lechuga, MOPSO: A proposal for multiple
% objective particle swarm optimization, Proceedings of the IEEE Congress
% on Evolutionary Computation, 2002, 1051-1056.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Parameter setting
    if nargin < 4
        W = 0.4;
    end
    ParticleDec = Particle.decs;
    PbestDec    = Pbest.decs;
    GbestDec    = Gbest.decs;
    [N,D]       = size(ParticleDec);
    ParticleVel = Particle.adds(zeros(N,D));

    %% Particle swarm optimization
    r1        = repmat(rand(N,1),1,D);
    r2        = repmat(rand(N,1),1,D);
    OffVel    = W.*ParticleVel + r1.*(PbestDec-ParticleDec) + r2.*(GbestDec-ParticleDec);
    OffDec    = ParticleDec + OffVel;
    Offspring = INDIVIDUAL(OffDec,OffVel);
end