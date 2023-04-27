function [NewPDec,NewInFill] = EliDup(PDec,InFill,InFillFlag,options)
% Eliminate the solutions having duplicated inputs or outputs to
% avoid unexpected errors in dacefit.m

    
    %% Check related parameters
    if ~isfield(options,'d'); options.d = 5;end
    if ~isfield(options,'subidx');options.subidx = sort(randperm(size(PDec,2),options.d));end
    if ~isfield(options,'residx');options.residx = setdiff(1:size(PDec,2),options.subidx);end
    
    SubIdx = options.subidx;
    ResIdx = options.residx;

    %% Eliminate the solutions having duplicated inputs or outputs
   
    if InFillFlag == 0 % DomiRank
        [~,distinct1] = unique(roundn(PDec,-6),'rows');
        distinct = distinct1;
    elseif InFillFlag ==1 % TChebycheff        
        [~,distinct1] = unique(roundn(PDec,-6),'rows');
        [~,distinct2] = unique(roundn(InFill,-6));
        distinct = intersect(distinct1,distinct2);
    end
    
    PDec     = PDec(distinct,:);
    InFill   = InFill(distinct);

    % Eliminate the solutions with sub-dimensions having duplicated inputs or outputs to
    % avoid unexpected errors in dacefit.m
    
    if InFillFlag == 0 % DomiRank
        [~,distinct1] = unique(roundn(PDec(:,SubIdx),-6),'rows');
        %[~,distinct2] = unique(roundn(InFill,-8));
        distinct = distinct1;
    elseif InFillFlag ==1 % TChebycheff        
        [~,distinct1] = unique(roundn(PDec(:,SubIdx),-6),'rows');
        [~,distinct2] = unique(roundn(InFill,-6));
        distinct = intersect(distinct1,distinct2);
    end
       
    NewPDec     = PDec(distinct,:);
    NewInFill   = InFill(distinct);
    
end

