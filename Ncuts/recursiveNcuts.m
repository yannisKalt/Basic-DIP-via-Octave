function clusterIdx = recursiveNcuts(anAffinityMat)
    
    % n: static-like variable
    % usage: (Sub)Graph Indexing
    %      : Defines label values.
    
    persistent n;
    if isempty(n)
        n = 0;
    end

    [M, ~] = size(anAffinityMat);
    verticesIndices = 1:M;

    if length(verticesIndices) < 5
        clusterIdx = [];
        return
    end

    labels = myNCuts(anAffinityMat, 2);
    ncut = calculateNcut(anAffinityMat, labels);

    % Change Threshold 1.12 To affect clustering%
    if ncut > 1.12 
        clusterIdx = [];
        return
    end

    clusterIdx = zeros(1, length(verticesIndices));
    low_cluster_value = 2 * n;
    high_cluster_value = 2 * n + 1;
    n = n + 1;

    %A, B subgraphs Of G
    % myNCuts returns a vector with values in set {1, 2}
    % V_A: Vertices of A subgraph
    % V_B: vertices of B subgraph
    
    V_A = verticesIndices(labels == 1);
    V_B = verticesIndices(labels == 2);

    V_A_labels = recursiveNcuts(anAffinityMat(V_A, V_A));
    V_B_labels = recursiveNcuts(anAffinityMat(V_B, V_B));

    if isempty(V_A_labels)
        clusterIdx(V_A) = low_cluster_value;
    else
        clusterIdx(V_A) = V_A_labels;
    end

    if isempty(V_B_labels)
        clusterIdx(V_B) = high_cluster_value;
    else
        clusterIdx(V_B) = V_B_labels;
    end
end
