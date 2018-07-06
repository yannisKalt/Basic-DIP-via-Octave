%-----------------------------------------------------------------%
% myConvSpat(imX, imY): Linear 2-D Convolution In Spatial Domain  %
% Input: imX, imY 2-D matrices                                    %
% Output: conv2(imX, imY) equivallent                             %
%-----------------------------------------------------------------%

function imOut = myConvSpat(imX, imY)

	% Test for wrong input.

	if (wrongInput(imX, imY)) 
		error('Invalid args to myConvSpat')
		return
	end

	% Typecast im1_gray, im2_gray to double to avoid operation overflow. 

	imY = double(imY);
	imX = double(imX);

	% Flip imX around origin and pad input arrays
	% to match relative pixel positions.

	imOut = zeros(size(imX) + size(imY) -1);
	imX_flipped = fliplr(flipud(imX));
	imX_flipped = padarray(imX_flipped, size(imY) -1, 'post');
	imY = padarray(imY, size(imX) -1, 'pre');
	
	% Perform convolution

	for n = 0:size(imOut)(2) -1
		for m = 0:size(imOut)(1) -1
			imOut(m + 1, n + 1) = sum(sum(circshift(imX_flipped, [m n]) .* imY));
		end
	end
end


%---------------------------------------------------------%
% isWrong: Checks if imX, imY Are Proper 2-D Matrices     %
% Input: imX, imY                                         %
% Output: Boolean value: isWrong                          %
%         isWrong = false iff imX, imY are 2-D Matrices   %
%---------------------------------------------------------%

function isWrong = wrongInput(imX, imY)
	isWrong = isscalar(imX) || isscalar(imY) ...
			  || ~ismatrix(imX) || ~ismatrix(imY);  
        
end
