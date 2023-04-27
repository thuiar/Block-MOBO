function BlockMOBO(Global)
% <algorithm> <B>
% High-dimensional Multi-objective Bayesian Optimization with Block
% Cordinate Updates
% IFEs --- 10000 --- Internal GA evals per iteration
% d --- 5 --- The number of sub-dimensions to optimize at each iteration

%------------------------------- Reference --------------------------------
% Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB 
% platform for evolutionary multi-objective optimization [educational forum], 
% IEEE Computational Intelligence Magazine, 2017, 12(4): 73-87.
%--------------------------------------------------------------------------

    %% Parameter setting
    [IFEs,d] = Global.ParameterSet(10000,5);
    options.fill = 'mix'; % "Fill-In" strategy
    InFillFlag = 1;

    %% Generate the weight vectors and random population
	[W,Global.N] = UniformPoint(Global.N,Global.M);
    N            = 11*Global.D-1;
    PopDec       = lhsamp(N,Global.D);
    Population   = INDIVIDUAL(repmat(Global.upper-Global.lower,N,1).*PopDec+repmat(Global.lower,N,1));
    theta        = 10.*ones(1,Global.D);
    [z,znad]     = deal(min(Population.objs),max(Population.objs));
        
    %% Optimization
    while Global.NotTermination(Population)
        % Randomly select a weight vector and preprocess the data
        lamda  = W(randi(size(W,1)),:);
        PopObj = Population.objs;
        [N,D]  = size(Population.decs); 
        
        %% Normalization
        [PopObj,z,znad] = Normalization(PopObj,z,znad);
        
        % Dominance Ranking and augment Tchebycheff funtion value
        DomiRankVal = DomRank(PopObj,W,options);
        PCheby = max(PopObj.*repmat(lamda,N,1),[],2)+0.05.*sum(PopObj.*repmat(lamda,N,1),2);
        
        % High-dimensional and Many-Objective MOBO
        rnd = rand();
        if rnd < 0.1
            InFillFlag = 0;
            InFill = DomiRankVal;
        else
            InFillFlag = 1;
            InFill = PCheby;     
        end
     
        if N > 11*D-1+25
            if InFillFlag==0 % DomiRank
                [~,index] = sort(InFill,'descend');
            elseif InFillFlag ==1 % TChebycheff
                [~,index] = sort(InFill);
            end
            Next      = index(1:11*D-1+25);
        else
            Next = true(N,1);
        end
        
        % Best solutions found so far
        PDec   = Population(Next).decs;
        InFill = InFill(Next);
        
        % Randomly choose d dimensions to deal with
        SubIdx = sort(randperm(D,d));
        ResIdx = setdiff(1:D, SubIdx);
        options.subidx = SubIdx;
        options.residx = ResIdx;
        
        % Eliminate the solutions having duplicated inputs or outputs
        [PDec,InFill] = EliDup(PDec,InFill,InFillFlag,options);
        
        % Surrogate-assisted prediction
        dmodel     = dacefit(PDec(:,SubIdx),InFill,'regpoly1','corrgauss',theta(:,SubIdx),1e-5.*ones(1,length(SubIdx)),20.*ones(1,length(SubIdx)));
        theta(:,SubIdx)      = dmodel.theta;
        
        % Maximizing EI on d dimensions
        SubPopulation = Population.decs;
        SubPopDec     = EvolALGInFill(InFill,SubPopulation(:,SubIdx),InFillFlag,dmodel,IFEs,options);
        
        % Fill-In Strategy
        if InFillFlag==1 % TChebycheff
            ResPopDec     = FillResPopCheby(PDec,InFill,options);
        elseif InFillFlag ==0 % DomRank
            ResPopDec     = FillResPopDom(PDec,InFill,options);
        end

        TempIdx = [SubIdx ResIdx];
        TempDec = [SubPopDec ResPopDec];
        [~,I]   = sort(TempIdx,2,'ascend');
        PopDec  = TempDec(I);
        
        Population = [Population,INDIVIDUAL(PopDec)];
    end
end