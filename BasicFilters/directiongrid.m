% directiongrid(theta, phi, M)
%
% Create an MxM Directional Grid
% 
%   - theta: Main angle.
%   - phi: Displacement angle

function directiongrid = directiongrid(theta, phi, M)
    
    % Acceptable angle input: Any value 
    % Convert Angle Range to (-180, 180].    
     
    % set theta in range (-180, 180]
    theta = fixAngle(theta);

    % create coords grid (centered)
    [Y, X] = meshgrid(1:M, 1:M);
    X = X - ceil(M/2);
    Y = Y - ceil(M/2);

    % create angle grid (centered).
    directiongrid = atan2d(Y, X); 
    
    omega1 = fixAngle(theta + abs(phi)/2); % omega2 < angle <= omega1
    omega2 = fixAngle(theta - abs(phi)/2);

    omega3 = fixAngle(omega2 + 180); % omega3 < angle <= omega4
    omega4 = fixAngle(omega1 + 180);


    % omega1 must lead omega2.
    % omega4 must lead omega3.
    % Discontinuity at angle- = -180, angle+ = 180 causes issues.
    % Must check explicitly. At discontinuity use logical Or instead of And. 


    if (omega1 >= omega2) 
        directiongridTemp = (directiongrid <= omega1) & (directiongrid > omega2);
    else
        directiongridTemp = (directiongrid <= omega1) | (directiongrid > omega2); 
    end

    if (omega4 >= omega3)
        directiongrid = directiongridTemp | ((directiongrid <= omega4) & (directiongrid > omega3));
    else
        directiongrid = directiongridTemp | ((directiongrid <= omega4) | (directiongrid > omega3));
    end
    % Symmetric Angle Grid
    % central point is set to 0 because of atan2d
    % set it to 1;
    directiongrid(ceil(M/2), ceil(M/2)) = 1;
    directiongrid = double(directiongrid);
end

% function fixAngle(angleIn)
%
%   Input:
%       angleIn: An angle in degrees (any value) 
%
%   Output:
%       angleOut: An angle in degrees(in range (-180, 180]

function angleOut = fixAngle(angleIn)
    if (~isscalar(angleIn))
        error('not scalar input');
    end
    while (angleIn > 180)
        angleIn = angleIn - 360;
    end
   
    while (angleIn <= -180)
        angleIn = angleIn + 360;
    end
    angleOut = angleIn;
end
