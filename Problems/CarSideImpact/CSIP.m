classdef CSIP < PROBLEM
% <problem> <CSIP>
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
        function obj = CSIP()
            obj.Global.M = 4;
            obj.Global.D = 7;
            
            obj.Global.lower    = [0.5, 0.45, 0.5, 0.5, 0.875, 0.4, 0.4];
            obj.Global.upper    = [1.5, 1.35, 1.5, 1.5, 2.625, 1.2, 1.2];
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
            
             % First original objective function
             PopObj(:,1) = repmat(1.98, N, 1) + 4.9 .* x1 + 6.67 .* x2 + 6.98 .* x3 + 4.01 .* x4 + 1.78 .* x5 + 0.00001 .* x6 + 2.73 .* x7;

             % Second original objective function
             PopObj(:,2) = repmat(4.72, N, 1) - 0.5 .* x4 - 0.19 .* x2 .* x3;

             % Third original objective function
             Vmbp = repmat(10.58,N,1) - repmat(0.674,N,1) .* x1 .* x2 - 0.67275 .* x2;
             Vfd = 16.45 - repmat(0.489,N,1).* x3 .* x7 - 0.843 .* x5 .* x6;
             PopObj(:,3) = 0.5 .* (Vmbp + Vfd);

             % Constraint functions
             g(:,1) = 1 -(1.16 - repmat(0.3717,N,1) .* x2 .* x4 - 0.0092928 .* x3);
             g(:,2) = 0.32 -(0.261 - 0.0159 .* x1 .* x2 - 0.06486 .* x1 -  0.019 .* x2 .* x7 + 0.0144 .* x3 .* x5 + 0.0154464 .* x6);
             g(:,3) = 0.32 -(0.214 + 0.00817 .* x5 - 0.045195 .* x1 - 0.0135168 .* x1 + repmat(0.03099,N,1) .* x2 .* x6 ...
                 - repmat(0.018,N,1) .* x2 .* x7  + repmat(0.007176,N,1).* x3 + repmat(0.023232,N,1) .* x3 - repmat(0.00364,N,1) .* x5 .* x6 - repmat(0.018,N,1) .* x2 .* x2);
             g(:,4) = 0.32 -(0.74 - 0.61 .* x2 - 0.031296 .* x3 - 0.031872 .* x7 + repmat(0.227,N,1) .* x2 .* x2);
             g(:,5) = 32 -(28.98 + 3.818 .* x3 - repmat(4.2,N,1) .* x1 .* x2 + 1.27296 .* x6 - 2.68065 .* x7);
             g(:,6) = 32 -(33.86 + 2.95 .* x3 - 5.057 .* x1 .* x2 - 3.795 .* x2 - 3.4431 .* x7 + 1.45728);
             g(:,7) =  32 -(46.36 - 9.9 .* x2 - 4.4505 .* x1);
             g(:,8) =  4 - PopObj(:,2);
             g(:,9) =  9.9 - Vmbp;
             g(:,10) =  15.7 - Vfd;

             % Calculate the constratint violation values
             g(g>=0)=0;
             g(g<0)=-g(g<0); 

             PopObj(:,4) = g(:,1) + g(:,2) + g(:,3) + g(:,4) + g(:,5) + g(:,6) + g(:,7) + g(:,8) + g(:,9) + g(:,10);
        end
        %% Sample reference points on Pareto front
        function P = PF(obj,N)
            load '/Users/happywhy/Documents/MATLAB/High-Dimensional-BO/PlatEMO-V2.9.0/PlatEMO/Problems/CarSideImpact/PF_CSIP.dat';
            P = PF_CSIP;
        end
    end
end