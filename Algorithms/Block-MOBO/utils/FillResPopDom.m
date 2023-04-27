function ResPopDec = FillResPopDom(PDec,DomiRank,options)
% ResPopDec fill-in strategy, including three kinds: random fill-in, copy the
% best solutions maxmizing the DomiRank found so far, and the mixture of
% above methods

%% Check the related input parameters
if ~isfield(options,'d'); options.d = 5;end
if ~isfield(options,'subidx');options.subidx = sort(randperm(size(PDec,2),options.d));end
if ~isfield(options,'residx');options.residx = setdiff(1:size(PDec,2),options.subidx);end

ResIdx = options.residx;

%% Fill in
if strcmp(options.fill, 'random') % Random      
    ResPopDec    = rand(1,length(ResIdx));             

elseif strcmp(options.fill, 'copy') % Copy
    BestIdx      = find(DomiRank==max(DomiRank));
    if length(BestIdx) >1
        RndBestIdx = randi([1,length(BestIdx)],1);
    elseif length(BestIdx)==1
        RndBestIdx = BestIdx;
    end               
    ResPopDec    = PDec(RndBestIdx,ResIdx);                  

elseif strcmp(options.fill, 'mix') % Mix
    if rand >= 0.1
        BestIdx      = find(DomiRank==max(DomiRank));
        if length(BestIdx)>1
            RndBestIdx = randi([1,length(BestIdx)],1);
        elseif length(BestIdx)==1
            RndBestIdx = BestIdx;
        end

        ResPopDec    = PDec(RndBestIdx,ResIdx);
    else
        ResPopDec    = rand(1,length(ResIdx));
    end

else
    fprintf('Fill strategy is illegal!');
end
end

