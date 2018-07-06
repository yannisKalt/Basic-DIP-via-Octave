function clusterIdx = mySpectralClustering(anAffinityMat, k)
    M = size(anAffinityMat);
    M = M(1);
    
    
    D = (transpose(sum(transpose(anAffinityMat))) * ones(1, M)) .* eye(M,M);

    % L: Laplacian Matrix.
    L = D - anAffinityMat;

    L = (L + transpose(L)) ./ 2;
    % U: k smallest eigenvectors of L. U = [u1 u2 ... uk]
    % lamda: eigenvalues of L placed in a k x k diagonal matrix.
    [U, ~] = eigs(L, k, 'sa');
    
    clusterIdx = kmeans(U, k);
end
