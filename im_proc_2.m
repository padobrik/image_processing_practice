clear;
close all hidden;

% Variant 10

% I have not found images built in matlab, but found smth similar,
% Added to repository :)
start_image = imread('image_lab2.tif');
image = uint8(double(rgb2gray(start_image) + 0.1));

% Aritmetic operations

% Formula for image processing in Variant 10: Y = 2.5X

image_arithm = immultiply(image, 2.5);


figure(1),
subplot(121), imshow(image), title('Original'); hold on;
subplot(122), imshow(image_arithm), title('With Arithmetic Operation'); hold on;

a = 10;
b = 7;
c = 12;
d = 3;

new_image = uint8(zeros(size(image)));
% Contrast stretching
% Linear piecewise stretching
for r = 1:size(image, 1)
    for col = 1:size(image, 2)
        pixel = uint8(image(r, col));
        new_pixel = (pixel - a) * ((d - c) / (b - a)) + c;
        new_image(r, col) = new_pixel;
    end
end

figure(2),
subplot(121), imshow(image), title('Original gray'); hold on;
subplot(122), imshow(new_image), title('After Linear Contrast Stretching'); hold on;

% Non-linear piecewise stretching
new_image_nl = uint8(zeros(size(image)));
for r = 1:size(image, 1)
    for col = 1:size(image, 2)
        gamma = 2;
        pixel = uint8(image(r, col));
        new_pixel_nl = (pixel - a) * ((d - c) / (b - a)) ^ gamma  + c;
        new_image_nl(r, col) = new_pixel_nl;
    end
end

figure(3),
subplot(121), imshow(image), title('Original gray'); hold on;
subplot(122), imshow(new_image_nl), title('After Non-Linear Contrast Stretching'); hold on;

% Complement stretching
new_image_c = uint8(zeros(size(image)));
for r = 1:size(image, 1)
    for col = 1:size(image, 2)
        pixel = uint8(image(r, col));
        if pixel > 128
            new_pixel_c = 255 - pixel;
            new_image_c(r, col) = new_pixel_c;
        else
            new_image_c(r, col) = pixel;
        end
    end
end

figure(4),
subplot(121), imshow(image), title('Original gray'); hold on;
subplot(122), imshow(new_image_c), title('After Complement Contrast Stretching'); hold on;
