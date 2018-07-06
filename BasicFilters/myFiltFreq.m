% myFiltFreq(imIn, someFilt): Perform Frequency Domain Filtering.
%   
%   - imIn: MxN image representation (spatial domain). 
%
%   - someFilt: MxN frequency domain representation of a filter. 
%                                                    
%   - imOut: MxN filtered image result (spatial domain).

function imOut = myFiltFreq(imIn, someFilt)
    
    % size(imIn) must be equal to size(someFilt) 
    if (~all(size(imIn) == size(someFilt)))
        error('Invalid input matrices size')
    end

    [M, N] = size(imIn);
    
    % K1, K2 form a proper meshgrid to express
    % the mathematical expression (-1)^(K1 + K2)
    % Reverse X <-> Y in meshgrid arguments, since typically
    % x represents rows and y columns in image processing,
    % while meshgrid operates in the oposite way.

    [K2, K1] = meshgrid(0:(N - 1), 0:(M - 1));

    % Use DFT Modulation Property to center the DFT of ImIn.
    % the expression (-1) .^ (K1 + K2) is a special case
    % when M,N are even numbers.
    
    % Use the same Property To demodulate the imOut.
    % floor(M/2) + ceil(M/2) = M. That is, the imOut
    % will have it's DFT un-centered with the DC term at imOut(1,1)

    modulateRows = exp((j * 2 * pi * floor(M/2)) / M .* K1);
    modulateColumns = exp((j * 2 * pi * floor(N/2)) / N .* K2);
    modulation = modulateRows .* modulateColumns;

    demodulateRows = exp((j * 2 * pi * ceil(M/2)) / M .* K1);
    demodulateColumns = exp((j * 2 * pi * ceil(N/2)) / N .* K2);
    demodulation = demodulateRows .* demodulateColumns;

    % Perform Filtering. 
    % Step 1: A = imIn .* modulation
    % Step 2: B = fft2(A)
    % Step 3: C = B .* someFilt
    % Step 4: D = ifft2(C)
    % Step 5: E = D .* demodulation. 
    % Step 6: F = real(E) Clear parasite complex numbers due to computational errors.
    imOut = real(ifft2((fft2(modulation .* imIn) .* someFilt)) .* demodulation); 
end

