%----------------------------------------------------------%
% myFilter(imX, aMask): Spatial Domain Conv Mask Filtering %
% Input:                                                   % 
%   1) imX: Input Image                                    %
%   2) aMask: Convolution Mask                             %
% Output: Filtered Image imOut (same dimentions as imX)    %       
% Constraints:                                             %
%   a) imX: M1 x N1 x N array {N, M1, N1 >= 0}             %
%   b) aMask: M2 x N2 x M array, {M = N or M = 1}          %
%----------------------------------------------------------%

function imOut = myFilter(imX, aMask)
	
	dim_imX = size(imX);
	dim_aMask = size(aMask);

	% Perform convolution. Four possible cases depending on input dimentions.

	switch (filt_case(imX, aMask))
		case 0
			imOut = 1;
			error('Invalid args to myFilter.');
		case 1
			imOut = zeros(dim_imX + dim_aMask - 1);
			imOut = myConvSpat(imX, aMask);
		case 2
			imOut = zeros([dim_aMask + dim_imX(1:2) - 1, dim_imX(3)]);
			for k = 1:dim_imX(3)
				imOut(:, :, k) = myConvSpat(imX(:, :, k), aMask);
			end
		case 3
			imOut = zeros([dim_imX(1:2) + dim_aMask(1:2) - 1, dim_imX(3)]);
			for k = 1:dim_aMask(3)
				imOut(:, :, k) = myConvSpat(imX(:, :, k), aMask(:, :, k));
			end
	endswitch

	% Typecast imOut to uint8: (pixel values in range [0, 255]

	imOut = im2uint8(mat2gray(imOut));

	% Remove borders to match imfilter(imX, aMask, 'conv') call.
	% imOut will have the same size as imX.
	% Default: On
	% Comment line 47 -> 49 if you do not wish such behavior. 

	rows_rem = dim_aMask(1) - 1;
	cols_rem = dim_aMask(2) - 1;
	reduce_borders();

	% Nested function to reduce imOut Borders %

	function reduce_borders()
		switch (length(size(imOut)))	
			case 2
				[M, N] = size(imOut);
				if (mod(rows_rem, 2) == 0 && rows_rem ~= 0)
					imOut([1:(rows_rem / 2), M:-1:(M + 1 - rows_rem / 2)], :) = [];
				else
					imOut([1:floor(rows_rem / 2), M], :) = [];
				endif
	
				if (mod(cols_rem, 2) == 0 && cols_rem ~= 0)
					imOut(:, [1:(cols_rem / 2), (N:-1:N + 1 - cols_rem / 2)]) = [];
				else
					imOut(:, [1:floor(rows_rem / 2), N]) = [];
				endif
			case 3
				[M, N, K] = size(imOut);
					if (mod(rows_rem, 2) == 0 && rows_rem ~= 0)
						imOut([1:(rows_rem / 2), M:-1:(M + 1 - rows_rem / 2)], :, :) = [];
					else
						imOut([1:floor(rows_rem / 2), M], :, :) = [];
					endif
	
					if (mod(cols_rem, 2) == 0 && cols_rem ~= 0)
						imOut(:, [1:(cols_rem / 2), (N:-1:N + 1 - cols_rem / 2)], :) = [];
					else
						imOut(:, [1:floor(rows_rem / 2), N], :) = [];
					endif
		endswitch	
	end

end

%-----------------------------------------------------%
% filt_case: Guide The Filtering Process              %
% Input:                                              %  
%   1) imX: Input Image                               %
%   2) aMask: Convolution Mask                        %
% Output: Integer In Set{0, 1, 2, 3}                  %
%         Determines The Filtering Process            %
%         case 0: Wrong Input                         %
%         case 1: imX Grayscale, aMask 2-D Matrix     %
%         case 2: imX N-channel, aMask 2-D Matrix     %
%         case 3: imX N-Channel, aMask N-channel Mask %
%-----------------------------------------------------%

function filt_case = filt_case(imX, aMask)
	if isscalar(imX) || isscalar(aMask)
		% Invalid Input, Scalars %
		filt_case = 0;
	elseif (ismatrix(imX) && ~(ismatrix(aMask)))
		% Invalid Input
		% imX: 2-D GrayScale Image
		% aMask: M-D mask, M > 2
		filt_case = 0;
	elseif ismatrix(imX) && ismatrix(aMask)
		% imX: 2-D GrayScale Image
		% aMask: 2-D Mask
		filt_case = 1;
	elseif (length(size(imX)) == 3) && ismatrix(aMask)
		% imX: N-Channel Image
		% aMask: 2-D Mask
		filt_case = 2;
	elseif size(imX)(3) == size(aMask)(3)
		% imX: N-Channel Image
		% aMask: N-Channel Mask
		filt_case = 3;
	endif
end


