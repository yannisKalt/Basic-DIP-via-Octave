%-------------------------------------------------------------------%
% myConvFreq(imX, imY): Linear 2-D Convolution In Frequency Domain  %
% Input: Two 2-D matrices                                           %
% Output: conv2 equivallent                                         %
%-------------------------------------------------------------------%

function imOut = myConvFreq(imX, imY)

	% Test for wrong input.
	if (wrongInput(imX, imY)) 
		disp('Wrong Input')
		return
	end

	% Typecast im1_gray, im2_gray to double to avoid operation overflow. 
	imX = double(imX);
	imY = double(imY);

	% Pad matrices. 
	imX_padded = padarray(imX, size(imY) - 1, 'post');
	imY_padded = padarray(imY, size(imX) - 1, 'post');

	% Compute conv2.
	imOut = real(ifft2(fft2(imX_padded) .* fft2(imY_padded)));

end

%---------------------------------------------------------%
% isWrong: Checks Whether imX, imY Are 2-D Matrices       %
% Input: imX, imY                                         %
% Output: Boolean value: isWrong                          %
%		  isWrong = false iff imX, imY are 2-D Matrices   %
%---------------------------------------------------------%

function isWrong = wrongInput(imX, imY)
	isWrong = isscalar(imX) || isscalar(imY) ...
			  || ~ismatrix(imX) || ~ismatrix(imY);
end
