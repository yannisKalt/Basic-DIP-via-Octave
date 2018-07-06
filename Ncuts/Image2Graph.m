function myAffinityMat = Image2Graph(imIn)

    [M, N, C] = size(imIn);
    
    % * imgVec = [x1 x2 ... ] --a C * (M*N) Matrix--
    % * xi = [xi_channel1 xi_channel2 ... xi_channelC]' 
    %        -- a color vector associated with pixel i -- 
    % * i takes values from 1 to (M * N).
    %     i = 1 -> pixel at imIn(1,1,:)
    %     i = 2 -> pixel at imIn(2,1,:) etc..
    %     i = M + 1 -> pixel at imIn(1,2,:) 
    %     and so on and so forth..

    imgVec = transpose(reshape(imIn, [M * N, C]));

    % G: Gramian Matrix
    G = transpose(imgVec) * imgVec;

    % D: Distance Matrix
    D = sqrt(-2 .* G + (ones(M * N, 1) * transpose(diag(G))) ... 
                + diag(G) * ones(1, M * N));

    myAffinityMat = exp(-D);
end

