function [TFrontNo,MaxTFNo,class] = tNDSort(PopObj,W)
% Theta-non-dominated sorting in high-dimensional multi-objective Bayesian
% optimizattion with combined coordinates rotation


%------------------------------- Reference --------------------------------
% [1] Y. Yuan, H. Xu, B. Wang, and X. Yao, A new dominance relation-based
% evolutionary algorithm for many-objective optimization, IEEE Transactions
% on Evolutionary Computation, 2016, 20(1): 16-37.
% [2] Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB 
% platform for evolutionary multi-objective optimization [educational forum]
% , IEEE Computational Intelligence Magazine, 2017, 12(4) : 73-87.
%--------------------------------------------------------------------------

    N  = size(PopObj,1);
    NW = size(W,1);

    %% Calculate the d1 and d2 values for each solution to each weight
    normP  = sqrt(sum(PopObj.^2,2));
    Cosine = 1 - pdist2(PopObj,W,'cosine');
    d1     = repmat(normP,1,size(W,1)).*Cosine;
    d2     = repmat(normP,1,size(W,1)).*sqrt(1-Cosine.^2);
    
    %% Clustering
    [~,class] = min(d2,[],2);
    
    %% Sort
    theta = zeros(1,NW) + 5;
    theta(sum(W>1e-4,2)==1) = 1e6;
    TFrontNo = zeros(1,N);
    for i = 1 : NW
        C = find(class==i);
        [~,rank] = sort(d1(C,i)+theta(i)*d2(C,i));
        TFrontNo(C(rank)) = 1 : length(C);
    end
    MaxTFNo = max(TFrontNo);
end

