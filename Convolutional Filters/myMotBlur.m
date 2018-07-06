%------------------------------------------------------------------------%
% myMotBlur(imX, mot_vec, exposure_time): Perform Motion Blurring on imX %
% Input:                                                                 %  
%   1) imX: Input Image                                                  %
%   2) mot_vec: A vector (n1, n2) representing the direction of img      % 
%               movement. Units[pixels / sec].                           %
%      n1: Vertical axis coordinate (points on rows).                    %
%      n2: Horizontal axis coordinate (points on columns).               %
%      Coord System Origin: Top left element of imX (a.k.a imX(1,1)).    % 
%   3) exposure_time: Unit[sec]. Expresses the duration                  %
%                                of motion blurring.                     % 
% Output:                                                                %
%   1) imOut: Filtered Image Output                                      %
%   2) myMotBlurMask: convolution mask for spatial filtering             %
%------------------------------------------------------------------------%

function [imOut, myMotBlurMask] = myMotBlur(imX, mot_vec, exposure_time)
	
	line_len = round(norm(mot_vec) * exposure_time);	
	
	% We wish myMotBlurMask to have a center => odd rows and columns
	% => line_len shall be odd number of pixels.

	if (mod(line_len, 2) == 0) 
		line_len = line_len + 1; 
	endif	

	theta = atan2(mot_vec(2), mot_vec(1));
	h = zeros(line_len, line_len);

	% Draw a vertical line with ones in the central column of h.
	
	h(:, ceil(size(h)(2) / 2)) = 1;
	
	% Perform linear rotational transform and interpolation to find myMotBlurMask.
	% Need to Reverse Arguments X <-> Y, otherwise the rotation is clockwise due to
	% meshgrid.  
	
	% T: Linear Transformation Matrix

	T = [cos(theta), -sin(theta); sin(theta), cos(theta)]; 
	
	[Y, X] = meshgrid(-(line_len - 1)/2:(line_len - 1)/2);
	h_coords_grid = [X(:)' ; Y(:)'];

	X_Inter = reshape((inverse(T) * h_coords_grid)(1, :), line_len, line_len);
	Y_Inter = reshape((inverse(T) * h_coords_grid)(2, :), line_len, line_len);

	myMotBlurMask = interp2(Y, X, h, Y_Inter, X_Inter);
	myMotBlurMask(isna(myMotBlurMask)) = 0;

	% Normalize mask.
	myMotBlurMask = myMotBlurMask / sum(myMotBlurMask(:));
	
	% Perform Filtering.
	imOut = myFilter(imX, myMotBlurMask);

end

	 
	 
