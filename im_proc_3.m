clear;
close all hidden;

% Upload images

image_1 = uint8(imread('m83.tif'));
image_2 = uint8(imread('snowflakes.png'));
image_3 = uint8(im2gray(imread('water.jpg')));
image_4 = uint8(imread('liftingbody.png'));
image_5 = uint8(imread('tire.tif'));
image_6 = uint8(imread('spine.tif'));
image_7 = uint8(imread('eight.tif'));
image_8 = uint8(imread('cell.tif'));
image_9 = uint8(imread('westconcordorthophoto.png'));
image_10 = uint8(imread('football.jpg'));

% Create specific filter for each of them

filter_average = fspecial('average', 3);
image_1_average = imfilter(image_1, filter_average, 'symmetric');

image_2_gauss = imgaussfilt(image_2, 5, 'FilterSize', 3); % replicate - default

image_3_fir = imag(hilbert(image_3)); % Take real part of Hilbert Transformation

% Plot Original vs Filtered

figure(1),
subplot(321), imshow(image_1), title('Original Image'), hold on;
subplot(322), imshow(image_1_average), title('Average Filter'), hold on;
subplot(323), imshow(image_2), title('Original Image'), hold on;
subplot(324), imshow(image_2_gauss), title('Gauss Filter'), hold on;
subplot(325), imshow(image_3), title('Original Image'), hold on;
subplot(326), imshow(image_3_fir), title('Hilbert Filter'), hold on;

% Release high pass filters

image_4_prewitt = edge(image_4, 'prewitt');
image_5_sobel = edge(image_5, 'sobel');
image_6_laplacian = edge(image_6, 'log');
image_7_roberts = edge(image_7, 'roberts');
image_8_canny = edge(image_8, 'canny');

% Plot high pass filters

figure(2),
subplot(5,2,1), imshow(image_4), title('Original Image'), hold on;
subplot(5,2,2), imshow(image_4_prewitt), title('Prewitt Filter'), hold on;
subplot(5,2,3), imshow(image_5), title('Original Image'), hold on;
subplot(5,2,4), imshow(image_5_sobel), title('Sobel Filter'), hold on;
subplot(5,2,5), imshow(image_6), title('Original Image'), hold on;
subplot(5,2,6), imshow(image_6_laplacian), title('Laplacian Filter'), hold on;
subplot(5,2,7), imshow(image_7), title('Original Image'), hold on;
subplot(5,2,8), imshow(image_7_roberts), title('Roberts Filter'), hold on;
subplot(5,2,9), imshow(image_8), title('Original Image'), hold on;
subplot(5,2,10), imshow(image_8_canny), title('Canny Filter'), hold on;

% 2-D FIR Filter

ord = 4;
band = [0.5 0.6];
high_pass_filter = fir1(ord, band, 'high');
two_dim_filter = ftrans2(high_pass_filter); % requires an odd order of 1-D filter ('odd' in fir1())
image_9_2d = imfilter(image_9, two_dim_filter);

% Plot 2-D filter

figure(3),
subplot(121), imshow(image_9), title('Original Image'); hold on;
subplot(122), imshow(image_9_2d), title('2-D Filtered Image'); hold on;

% Fast Fourier Transform Filter (2-D)

image_10_fourier = imag(fft2(image_10));

% Plot FFT filter

figure(4),
subplot(121), imshow(image_10), title('Original Image'); hold on;
subplot(122), imshow(fftshift(image_10_fourier)), title('FFT Frequency Domain'); hold on;
