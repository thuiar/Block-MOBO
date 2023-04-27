function PopDec = EvolALGInFill(InFill,Dec,InFillFlag,model,IFEs,options)
% Solution update in CCR-MBO, where a solution with the best expected
% improvement is re-evaluated

%------------------------------- Reference --------------------------------
% Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB 
% platform for evolutionary multi-objective optimization [educational forum], 
% IEEE Computational Intelligence Magazine, 2017, 12(4): 73-87.
%--------------------------------------------------------------------------

    Off   = [GADrop(Dec(TournamentSelection(2,size(Dec,1),InFill),:),options);GADrop(Dec,options,{0,0,1,20})];
    N     = size(Off,1);
    EI    = zeros(N,1);
    E0    = inf;
    
    if InFillFlag==0 % Domirank
        [Gbest,idx] = max(InFill);
    elseif InFillFlag == 1 % PCheby
        [Gbest,idx] = min(InFill);
    end
    

    while IFEs > 0
        drawnow();
        for i = 1 : N
            [y,~,mse] = predictor(Off(i,:),model);
            s         = sqrt(mse);
            EI(i)     = -(Gbest-y)*normcdf((Gbest-y)/s)-s*normpdf((Gbest-y)/s);
        end
        [~,index] = sort(EI);
        if EI(index(1)) < E0
            Best = Off(index(1),:); 
            E0   = EI(index(1));
        else
            Best = Off(idx,:);           
        end
        Parent = Off(index(1:ceil(N/2)),:);
        Off    = [GADrop(Parent(TournamentSelection(2,size(Parent,1),EI(index(1:ceil(N/2)))),:),options);GADrop(Parent,options,{0,0,1,20})];
        IFEs   = IFEs - size(Off,1);
    end
    PopDec = Best;
end