% Fahim Mannan (fmannan@gmail.com)
% Vectorized bilateral filter
function B = bfilter(A,w,sigma)

if ismatrix(A) || ndims(A) == 3
    B = bfilter2_vec_3d(A, w, sigma);
else
    assert(false, 'Not Supported')
end    


function B = bfilter2_vec_3d(A, w, sigma)
sigma_d = sigma(1);
sigma_r = sigma(2);
w = ceil(w);

G = compute_space_kernel(sigma_d, w);
[bfKernel, imc] = compute_range_kernel(A, w, sigma_r);

imc_bfKernel = bsxfun(@times,imc, bfKernel);
vec_tensor = G(:)' * reshape(imc_bfKernel, size(imc_bfKernel, 1), size(imc_bfKernel, 2) * size(imc_bfKernel, 3));
vec_tensor = reshape(vec_tensor, [1, size(imc_bfKernel, 2), size(imc_bfKernel, 3)]);
imf = bsxfun(@rdivide, vec_tensor, G(:)' * bfKernel);
B = reshape(imf, size(A));


function Kspace = compute_space_kernel(sigma_d, w)
% Pre-compute Gaussian distance weights.
[X,Y] = meshgrid(-w:w,-w:w);
Kspace = exp(-(X.^2+Y.^2)/(2*sigma_d^2));

function [Krange, imc] = compute_range_kernel(A, w, sigma_r)

w = ceil(w);
imc = nan((2*w+1)^2, size(A, 1) * size(A, 2), size(A, 3));
for ch = 1:size(A, 3)
    imc(:,:,ch) = im2col(padarray(A(:,:,ch), [w, w], 'replicate'), [2*w + 1, 2*w+1], 'sliding');
end

center = ((2 * w + 1)^2 + 1)/2;
Krange = bsxfun(@minus, imc, imc(center,:,:));
Krange = exp(-sum(Krange.^2, 3) / (2*sigma_r^2));

