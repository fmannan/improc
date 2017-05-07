% Fahim Mannan (fmannan@cim.mcgill.ca)
% test mtf estimation code

close all
clear
clc

im = create_slanted_edge(51, 90, 1.2);
figure; imshow(im)
figure; plot(sum(im))
dx = gradient(sum(im));
figure; plot(dx)

imf = fft(dx);
mtf = abs(fftshift(imf));

figure;
plot(mtf)

x = 1:length(mtf);
mtf_n = (mtf / sum(mtf(:)));
center_x = sum(x .* mtf_n);

mtf_n_c = mtf_n(center_x:end);
figure
plot(mtf_n_c)
%%
mtf = vert_edge_mtf(im);
figure
plot(mtf)


%% slanted edge
nbins = 4;
im_edge = im2double(imread('mtf_test.png'));
[mtf_norm, mtf_res] = slanted_edge_mtf(im_edge, nbins);

h = figure;
imshow(im_edge)

figure
plot(mtf_norm)

%% detect slanted edge pos
[esf, x_est, slope, offset] = slanted_edge_to_esf(im_edge, nbins);
x = 1:size(im_edge, 1);
figure
imshow(im_edge)
hold on
plot(x_est, x, 'r--')