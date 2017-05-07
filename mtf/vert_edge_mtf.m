% vert_edge_mtf.m
% Fahim Mannan (fmannan@cim.mcgill.ca)
% input image is a vertical edge
function [mtf, mtf_full] = vert_edge_mtf(im)
% to be consistent with how mtf's are reported no fftshift and truncate to half

h = [-.5, 0, .5];
im = padarray(im, [1, 1], 'symmetric');
lsf = conv2(im, h, 'valid');
psf = mean(lsf, 1);
mtf_full = abs(fft(psf));
mtf = mtf_full(:,1:ceil(end/2));
mtf_full = fftshift(mtf_full);

