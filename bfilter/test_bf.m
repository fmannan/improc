close all
clc
clear

SRC_DIR = './';
files = {'steps1.png', 'kodim23.png'};

for idx = 1:length(files)
    filename = [SRC_DIR char(files(idx))]
    im_orig = im2double(imread(filename));

    im = im_orig + randn(size(im_orig)) * 0.05;

    figure
    imshow(im)

    window = 15;
    sigmas = [2.2, .1];

    imbf = bfilter(im, window, sigmas);

    figure;
    imshow(imbf)
end

