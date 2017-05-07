% create_slanted_edge.m
% Fahim Mannan (fmannan@cim.mcgill.ca)

function [im, im_angle] = create_slanted_edge(half_size, angle_deg, gauss_sigma)

if ~exist('gauss_sigma', 'var')
    gauss_sigma = 0;
end

half_blur_width = 0;
if(gauss_sigma > 0)
    half_blur_width = ceil(3 * gauss_sigma);
    blur_width = 2 * half_blur_width + 1;
    h = fspecial('gaussian', blur_width, gauss_sigma);
end
N = 2 * (half_size + half_blur_width) + 1;

[X, YY] = meshgrid(linspace(-1, 1, N), linspace(-1, 1, N));
Y = -YY;
im_angle = atan2(Y, X);
im_angle(im_angle < 0) = im_angle(im_angle < 0) + 2 * pi;

angle_rad = deg2rad(angle_deg);
im = double(im_angle <= angle_rad | im_angle >= angle_rad + pi);

if(gauss_sigma > 0)
   im = conv2(im, h, 'valid');
end
