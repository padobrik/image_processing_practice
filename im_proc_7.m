clear;
close all hidden;

% Read Images

image_1 = imread('cameraman.tif');
image_2 = imread('onion.png');

% Pseudo-Color Processing

image_1_sliced = grayslice(image_1, 16);

figure(1),
subplot(121), imshow(image_1_sliced, jet(16)), title('Jet Pseudo-Colorization'); hold on;
subplot(122), imshow(image_1_sliced, winter(16)), title('Winter Pseudo-Colorization'); hold on;

% Luminance Correction

color = [128 128 40];
background = [150 150 150];

figure(2),
subplot(121), imshow(image_2), title('Original Image');

w = 64;
v = zeros(1, 3);
[n, m, k] = size(image_2);
for i = 1:n
    for j = 1:m
        v(1:3) = image_2(i, j, 1:3);
        if norm(v - color) > w
            image_2(i, j, 1:3) = background;
        end
    end
end

subplot(122), imshow(image_2), title('After Luminance Correction');

% Image Segmentation

image_2_hsv = rgb2hsv(image_2);
color = 0.01;
background = [0 0.2 0.4];
w = 0.1;
[p, q, r] = size(image_2_hsv);

figure(3),
subplot(121), imshow(image_2_hsv), title('HSV Image');
for i = 1:p
    for j = 1:q
        v = image_2_hsv(i, j, 1);
        if abs(v - color) > w
            image_2_hsv(i, j, 1:3) = background(1:3);
        end
    end
end

subplot(122), imshow(image_2_hsv), title('After Segmentation');
