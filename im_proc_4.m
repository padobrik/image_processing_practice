clear;
close all hidden;

% Do Radon Transformation

im_angle = imread("findAngle7.png");
im_rect = imread("findRect7.png");

im_angle_bin = edge(im_angle);
im_rect_bin = edge(im_rect);

% Find the center of the images
[ny1, nx1] = size(im_angle);
[ny2, nx2] = size(im_rect);
C1 = round([nx1 ny1] / 2);
C2 = round([nx2 ny2] / 2);

figure(1),
subplot(221), imshow(im_angle), title("Original Angle"); hold on;
subplot(222), imshow(im_angle_bin), title("Binarized Angle"); hold on;
subplot(223), imshow(im_rect), title("Original Rectangle"); hold on;
subplot(224), imshow(im_rect_bin), title("Binarized Rectangle"); hold on;

theta = 0:180;
[R1, xp1] = radon(im_angle_bin, theta);
[R2, xp2] = radon(im_rect_bin, theta);

% Find the location of the peak of the radon transform image

maxR1 = max(R1(:));
maxR2 = max(R2(:));
[rowOfMax1, columnOfMax1] = find(R1 == maxR1);
[rowOfMax2, columnOfMax2] = find(R2 == maxR2);

str1 = sprintf('Coordinates of the Radon Rectangle Transform max peak: (%d, %d)', columnOfMax2, xp2(rowOfMax2));
str2 = sprintf('Coordinates of the Radon Angle Transform max peak: (%d, %d)', columnOfMax1, xp1(rowOfMax1));
disp(str1);
disp(str2);

% Display the Radon Transform image

figure(2),
h1 = subplot(121);
imshow(R1, [], 'Xdata', theta, 'Ydata', xp1, ...
            'InitialMagnification','fit'), title('Radon Transformation of Angle + peak'), xlabel('\theta (degrees)'), ...
ylabel('x^{\prime} (pixels from center)'), colormap(hot);
axis on; hold on;
plot(h1, columnOfMax1, xp1(rowOfMax1), 'bo', 'MarkerSize', 30, 'LineWidth', 3); % Plot a blue circle over the max.

h2 = subplot(122);
imshow(R2, [], 'Xdata', theta, 'Ydata', xp2, ...
            'InitialMagnification','fit'), title('Radon Transformation of Rect + peak'); colormap(hot);
axis on; hold on;
plot(h2, columnOfMax2, xp2(rowOfMax2), 'bo', 'MarkerSize', 30, 'LineWidth', 3);

% Release Correlation Function

I = imread('text.png');
[nI, mI] = size(I);
P = I(1:30, 45:52); % coordinates for 't' letter
[nP, mP] = size(P);

figure(3), 
subplot(121), imshow(I), title('Original Image'); hold on;
subplot(122), imshow(P), title('Pattern Image'); hold on;

% Complete the image to size(original + t)

I(:, mI:mI+mP) = 0;
I(nI:nI+nP, :) = 0;
figure(3), imshow(I), title('Larger original Image')
P(:, mP:mI) = 0;
P(nP:nI, :) = 0;
P(nI:nI+nP, :) = 0;
P(:, mI+mP) = 0;

figure(4), 
subplot(121), imshow(I), title('Larger original Image'); hold on;
subplot(122), imshow(P), title('Larger pattern image'); hold on;

% Do Magic Fourier Transformation

fourier_I = fft2(double(I*255));
fourier_P = fft2(double(P*255));
complex_fourier_P = conj(fourier_P); 
F = fourier_I .* complex_fourier_P;
R = ifft2(F); 
for i = 1:mI
    for j = 1:nI
        if R(i, j) < 0
            R(i,j) = 0; 
        end
    end
end
    
R = R / max(max(R));
for i = 1:mI
    for j = 1:nI
        if R(i, j) > 0.950 
            k = i;
            l = j;
            break;
        end
    end
end
        
figure(7), imshow(R), title('Correlation');


