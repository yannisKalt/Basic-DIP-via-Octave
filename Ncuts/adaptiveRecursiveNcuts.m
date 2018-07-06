function clusterIdx = adaptiveRecursiveNcuts(anAffinityMat, T)
    % recursive ncuts algorithm
    % ncut_threshold changes in the following manner:
    %
    %           G(V,E) 
    %           |    |
    %          A      B  
    %        |   |
    %       A1   A2
    
    % ncut_threshold(A) = ncut(G)
    % ncut_threshold(A1) = ncut_threshold(A2) = ncut(A)
    % ncut_threshold(B) = ncut(G)
    % etc..
    
    persistent n;
    if isempty(n)
        n = 0;
        T = 2;
    end
    
    [M, ~] = size(anAffinityMat);
    verticesIndices = 1:M;
    
    if length(verticesIndices) < 5
        clusterIdx = [];
        return
    end
    
    labels = myNCuts(anAffinityMat, 2);
    ncut = calculateNcut(anAffinityMat, labels);
    
    if ncut > T
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

    V_A_labels = adaptiveRecursiveNcuts(anAffinityMat(V_A, V_A), ncut);
    V_B_labels = adaptiveRecursiveNcuts(anAffinityMat(V_B, V_B), ncut);

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
