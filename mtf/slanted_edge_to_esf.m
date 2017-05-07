% slanted_edge_to_esf.m
% Fahim Mannan (fmannan@cim.mcgill.ca)
% Returns the edge spread function, position of the edge, slope and offset
% of the edge.
function [esf, x_est, slope, offset] = slanted_edge_to_esf(im_edge, nbins)
[nRows, nCols] = size(im_edge);
y = 1:nRows;
x = 1:nCols;

% estimate the center on each line
dx = gradient(im_edge);
dxn = bsxfun(@rdivide, dx, sum(dx, 2));

% column where the edge is
xc = dxn * x';

% fit a line through the centers
A = x(:);
A(:, 2) = 1;
sol = A \ xc;
slope = sol(1);
offset = sol(2);

% find position of line on each row
x_est = [y(:), ones(length(y(:)), 1)] * sol;

% find the inverse transformation from bin index to grid
[X0, Y0] = meshgrid(1:nCols, 1:nRows);
[X, Y] = meshgrid(1:nCols * nbins, 1:nRows);
Xinv = X / nbins + Y * sol(1);

esf = interp2(X0, Y0, im_edge, Xinv, Y);