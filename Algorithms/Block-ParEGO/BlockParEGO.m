function BlockParEGO(Global)
% <algorithm> <B>
% ParEGO with Block Coordinate Update
% IFEs --- 10000 --- Internal GA evals per iteration
% d --- 5 --- The number of sub-dimensions to optimize at each iteration

%------------------------------- Reference --------------------------------
% [1] J. Knowles, ParEGO: A hybrid algorithm with on-line landscape
% approximation for expensive multiobjective optimization problems, IEEE
% Transactions on Evolutionary Computation, 2006, 10(1): 50-66.
% [2] Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB 
% platform for evolutionary multi-objective optimization [educational forum], 
% IEEE Computational Intelligence Magazine, 2017, 12(4): 73-87.
%--------------------------------------------------------------------------

    %% Parameter setting
    [IFEs,d] = Global.ParameterSet(10000,5);
    options.fill = 'mix'; 

    %% Generate the weight vectors and random population
	[W,Global.N] = UniformPoint(Global.N,Global.M);
    N            = 11*Global.D-1;
    PopDec       = lhsamp(N,Global.D);
    Population   = INDIVIDUAL(repmat(Global.upper-Global.lower,N,1).*PopDec+repmat(Global.lower,N,1));
    theta        = 10.*ones(1,Global.D);
        
    %% Optimization
    while Global.NotTermination(Population)
        % Randomly select a weight vector and preprocess the data
        lamda  = W(randi(size(W,1)),:); 
        PopObj = Population.objs;
        [N,D]  = size(Population.decs);
        PopObj = (PopObj-repmat(min(PopObj,[],1),N,1))./repmat((max(PopObj,[],1)-min(PopObj,[],1)),N,1); % normalize
        
        % Tchebycheff value used to save the current best solutions
        PCheby = max(PopObj.*repmat(lamda,N,1),[],2)+0.05.*sum(PopObj.*repmat(lamda,N,1),2); 
     
        if N > 11*D-1+25
            [~,index] = sort(PCheby);
            Next      = index(1:11*D-1+25);
        else
            Next = true(N,1);
        end
        
        % Best solutions found so far
        PDec   = Population(Next).decs;
        PCheby = PCheby(Next);
        
        % Eliminate the solutions having duplicated inputs or outputs
        [~,distinct1] = unique(roundn(PDec,-6),'rows');
        [~,distinct2] = unique(roundn(PCheby,-6));
        distinct = intersect(distinct1,distinct2);
        PDec     = PDec(distinct,:);
        PCheby   = PCheby(distinct);
        
        SubIdx = sort(randperm(D,d));
        ResIdx = setdiff(1:D, SubIdx);
        options.subidx = SubIdx;
        options.residx = ResIdx;
        
        % Eliminate the solutions having duplicated inputs or outputs
        [~,distinct1] = unique(roundn(PDec(:,SubIdx),-6),'rows');
        [~,distinct2] = unique(roundn(PCheby,-6));
        distinct = intersect(distinct1,distinct2);
        PDec     = PDec(distinct,:);
        PCheby   = PCheby(distinct);
        
        % Surrogate-assisted prediction
        dmodel     = dacefit(PDec(:,SubIdx),PCheby,'regpoly1','corrgauss',theta(:,SubIdx),1e-5.*ones(1,length(SubIdx)),20.*ones(1,length(SubIdx)));
        theta(:,SubIdx)      = dmodel.theta;
        
        % Maximizing EI in d-dimensional decision space
        SubPopulation = Population.decs;
        SubPopDec     = EvolALG(PCheby,SubPopulation(:,SubIdx),dmodel,IFEs,options); % d dimension
        
        % Three different Fill-In values: Random Value, Pareto Optimum and Mixed Value      
        if strcmp(options.fill, 'random') % Random Value     
            ResPopDec    = rand(1,length(ResIdx));             
       
        elseif strcmp(options.fill, 'copy') % Pareto Optimum
            BestIdx      = find(PCheby==min(PCheby));
            ResPopDec    = PDec(BestIdx,ResIdx);                  
        
        elseif strcmp(options.fill, 'mix') % Mixed Value
            if rand >= 0.1
                BestIdx      = find(PCheby==min(PCheby));
                ResPopDec    = PDec(BestIdx,ResIdx);
            else
                ResPopDec    = rand(1,length(ResIdx));
            end
            
        else
            fprintf('Fill strategy is illegal!');
        end
        
        TempIdx = [SubIdx ResIdx];
        TempDec = [SubPopDec ResPopDec];
        [~,I]   = sort(TempIdx,2,'ascend');
        PopDec  = TempDec(I);
        Population = [Population,INDIVIDUAL(PopDec)];
    end
end
