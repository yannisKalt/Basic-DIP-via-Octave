function nCutValue = calculateNcut(anAffinityMat, clusterIdx)
    
    % If G(V,E) Is the original graph, G will be cut into sub-graphs
    % (cluster-graphs) A, B hence the variable naming convention.
    
    % clusterIdx is a vector with values in set W = {label_min, label_max}
    % A: Represents the sub-graph with vertices labeled as label_min
    % B: Represents the sub-graph with vertices labeled as label_max
    
    label_min = min(clusterIdx);
    label_max = max(clusterIdx);
    
    % Compute partial affinity matrices.
      
    weightsA_A = anAffinityMat(clusterIdx == label_min, ...
                               clusterIdx == label_min);
    
    weightsB_B = anAffinityMat(clusterIdx == label_max, ...
                               clusterIdx == label_max);
    
    weightsA_B = anAffinityMat(clusterIdx == label_min, ...
                               clusterIdx == label_max);
                           
    weightsB_A = anAffinityMat(clusterIdx == label_max, ...
                               clusterIdx == label_min);
     
    % Compute assoc(A,A), assoc(A,V), assoc(B,B), assoc(B,V)
    % Assoc(A,V) = Assoc(A,A) + Assoc(A,B);
    %              since A, B form a partition of V.
    
    
    assocA_A = sum(weightsA_A(:)) / 2 + sum(diag(weightsA_A)) / 2; 
    assocB_B = sum(weightsB_B(:)) / 2 + sum(diag(weightsB_B)) / 2;
    
    assocA_B = sum(weightsA_B(:)); % = assocB_A
    assocB_A = sum(weightsB_A(:)); % = assocA_B
    
    
    assocB_V = assocB_B + assocB_A;
    assocA_V = assocA_A + assocA_B;
       
    NassocA_B = (assocA_A / assocA_V) + (assocB_B / assocB_V);
    nCutValue = 2 - NassocA_B;   
end
