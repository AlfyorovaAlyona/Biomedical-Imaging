function position = px2pos(pixel)
% PX2POS converts image coordinates to physical camera coordinates.
%
%   position = PX2POS(pixel)
%
%   Return the position of the pixel in camera coordinates (in metres).
%
%   The pixel is assumed to be in form [x(:), y(:)] in "standard picture
%   coordinates", where the top-left corner has value [1, 1] and the
%   bottom-right corner has value of [5204, 3472]. That is, the coordinate
%   system is left handed!
%
%   If pixel is a N × 2 matrix, then position is a 3 × N matrix.
%
%   For "standard picture coordinates", see:
%   http://se.mathworks.com/help/images/image-coordinate-systems.html
%
% Author Lari Koponen
% Version 2016-09-18

    % The focal length of the objective.
    focal_length = 50e-3;

    % The sensor dimensions for Canon 18 Mpx APS-C sensor.
    sensor_width = 22.3e-3;
    sensor_height = 14.9e-3;
    sensor_width_px = 5204;
    sensor_height_px = 3472;
    
    % Calculate the positions for the pixels.
    position = [ ...
       -sensor_width * ((pixel(:, 1) - .5) / sensor_width_px - .5), ...
        sensor_height * ((pixel(:, 2) - .5) / sensor_height_px - .5), ...
        ones(size(pixel, 1), 1) * focal_length, ...
    ].';
end

