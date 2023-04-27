function GCount = DomRank(PopObj,W,options)
% theta-Dominance Rank in high-dimensional multi-objective Bayesian
% optimization with Combined Coordinate Rotation


% Each solution 
[N,~] = size(PopObj);
[FrontNo, MaxFNo,cluster] = tNDSort(PopObj, W);
GCount = zeros(N,1);
Ranked  = zeros(N,1);

% Solution which dominates the most other solutions
for i=1: N
    % To avoid rerank
    if ismember(i,Ranked)
        i = i+1;
    else
        C = find(cluster==cluster(i));    
        for j=1:length(C)
            GCount(C) = length(find(FrontNo(C)<FrontNo(C(j))));
        end
        if length(C)==1
            GCount(C)= 1.0;
        else
            GCount(C) = 1.0 - GCount(C) ./(length(C)-1);
        end
    end
    Ranked(C) = C; % The indexes of ranked solutions to avoid reranking
end
end