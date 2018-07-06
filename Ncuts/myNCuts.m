function clusterIdx = myNCuts(anAffinityMat ,k)

    M = size(anAffinityMat);
    M = M(1);
   
    
    D = (transpose(sum(transpose(anAffinityMat))) * ones(1, M)) .* eye(M,M);

    % L: Laplacian Matrix.
    L = D - anAffinityMat;

    % Lx = λDx eigenvalue problem
    
    L = (L + transpose(L)) ./ 2;
    %D = (D + transpose(D)) ./ 2;
    
    [U, ~] = eigs(L, D, k, 'sa');
    
    clusterIdx = kmeans(U, k);
end
