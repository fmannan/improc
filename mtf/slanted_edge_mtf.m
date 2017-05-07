% slanted_edge_mtf.m
% Fahim Mannan (fmannan@cim.mcgill.ca)

function [mtf_norm, mtf_res] = slanted_edge_mtf(im_edge, nbins)
if ~exist('nbins', 'var')
    nbins = 4;
end
% given a slanted edge as input find all the frequencies
esf = slanted_edge_to_esf(im_edge, nbins);

lsf = gradient(nanmean(esf, 1));
lsf(isnan(lsf)) = 0;

otf = fft(lsf);

mtf_res = fftshift(abs(otf));
mtf_norm = abs(otf(1:end/2));
mtf_norm = mtf_norm / mtf_norm(1);
