classdef CSIP_R < PROBLEM
% <problem> <CSIP_R>
% Benchmark MOP proposed by Deb, Thiele, Laumanns, and Zitzler

%------------------------------- Reference --------------------------------
% [1] H. Jain and K. Deb, "An Evolutionary Many-Objective Optimization Algorithm 
% Using Reference-Point Based Nondominated Sorting Approach, Part II: Handling 
% Constraints and Extending to an Adaptive Approach," in IEEE Transactions on 
% Evolutionary Computation, vol. 18, no. 4, pp. 602-622, Aug. 2014.

% [2] Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    methods
        %% Initialization
        function obj = CSIP_R()
            obj.Global.M = 2;
            obj.Global.D = 11;
            
            obj.Global.lower    = [0.5, 0.45, 0.5, 0.5, 0.875, 0.4, 0.4,0, 0, -30, -30];
            obj.Global.upper    = [1.5, 1.35, 1.5, 1.5, 2.625, 1.2, 1.2, 1, 1, 30, 30];
            obj.Global.encoding = 'real';
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            [N,D]  = size(PopDec);
            x1 = PopDec(:,1);
            x2 = PopDec(:,2);
            x3 = PopDec(:,3);
            x4 = PopDec(:,4);
            x5 = PopDec(:,5);
            x6 = PopDec(:,6);
            x7 = PopDec(:,7);
            x8 = PopDec(:,8);
            x9 = PopDec(:,9);
            x10 = PopDec(:,10);
            x11 = PopDec(:,11);
            
            % X8 and X9 are material design variables, which are discrete
            %  and can only be either mild steel or high strength steel. We
            %  use 0/1 to represent MS/HSS.
            x8(x8<0.5) = 0;
            x8(x8>-0.5) = 1;
            
            x9(x9<0.5) = 0;
            x9(x9>-0.5) = 1;            
            
             % First original objective function
             PopObj(:,1) = repmat(1.98, N, 1) + 4.9 .* x1 + 6.67 .* x2 + 6.98 .* x3 + 4.01 .* x4 + 1.78 .* x5 + 0.00001 .* x6 + 2.73 .* x7;


             % Third original objective function
             Vmbp = repmat(10.58,N,1) - repmat(0.674,N,1) .* x1 .* x2 - 1.95.* x2.*x8+0.02054.*x3.*x10-...
                 0.0198.*x4.*x10+0.028.*x6.*x10;
             Vfd = 16.45 - repmat(0.489,N,1).* x3 .* x7 - 0.843 .* x5 .* x6+0.0432.*x9.*x10-0.0556.*x9.*x10-0.000786.*x11.*x11;
%              PopObj(:,3) = 0.5 .* (Vmbp + Vfd);

             % Constraint functions
             g(:,1) = 1 -(1.16 - repmat(0.3717,N,1) .* x2 .* x4 - 0.00931 .* x2.*x10-0.484.*x3.*x9+0.01342.*x6.*x10);
             g(:,2) = 0.32 -(0.261 - 0.0159 .* x1 .* x2 - 0.188 .* x1.*x8 -  0.019 .* x2 .* x7 + 0.0144 .* x3 .* x5 + 0.8757 .* x5.*x10+0.08045.*x6.*x9+0.00139.*x8.*x11+0.00001575.*x10.*x11);
             g(:,3) = 0.32 -(0.214 + 0.00817 .* x5 - 0.131 .* x1.*x8 - 0.0704 .* x1.*x9 + repmat(0.03099,N,1) .* x2 .* x6 ...
                 - repmat(0.018,N,1) .* x2 .* x7  + repmat(0.0208,N,1).* x3.*x8 + repmat(0.121,N,1) .* x3.*x9 - repmat(0.00364,N,1) .* x5 .* x6 + repmat(0.0007715,N,1) .* x5 .* x10-0.0005354.*x6.*x10+...
                 0.00121.*x8.*x11+0.00184.*x9.*x10-0.018.*x2.*x2);
             g(:,4) = 0.32 -(0.74 - 0.61 .* x2 - 0.163 .* x3.*x8 + 0.001232 .* x3.*x10 - repmat(0.166,N,1) .* x7 .* x9+0.227.*x2.*x2);
             g(:,5) = 32 -(28.98 + 3.818 .* x3 - repmat(4.2,N,1) .* x1 .* x2 + 0.0207 .* x5.*x10 + 6.63 .* x6.*x9-7.77.*x7.*x8+0.32.*x9.*x10);
             g(:,6) = 32 -(33.86 + 2.95 .* x3 + 0.1792 .* x10 - 5.057 .*x1.* x2 - 11.*x2.*x8-0.0215 .* x5.*x10 -9.98.*x7.*x8+22.*x8.*x9);
             g(:,7) =  32 -(46.36 - 9.9 .* x2 - 12.9 .* x1.*x8+0.1107.*x3.*x10);
             g(:,8) =  4 - (4.72-0.5.*x4-0.19.*x2.*x3-0.0122.*x4.*x10+0.009325.*x6.*x10+0.000191.*x11.*x11);
             g(:,9) =  9.9 - Vmbp;
             g(:,10) =  15.7 - Vfd;

             % Calculate the constratint violation values
             g(g>=0)=0;
             g(g<0)=-g(g<0); 
             
             % second objective function
             PopObj(:,2) = g(:,1) + g(:,2) + g(:,3) + g(:,4) + g(:,5) + g(:,6) + g(:,7) + g(:,8) + g(:,9) + g(:,10);
        end
        %% Sample reference points on Pareto front
        function P = PF(obj,N)
            load('/Users/happywhy/Documents/MATLAB/High-Dimensional-BO/PlatEMO-CSIP/PlatEMO/Data/CSIPR_PF.mat');
            P = CSIPR_PF;
        end
    end
end