clear;
close all hidden;

% Making array of image names
imArray = {'pears.png', 'rice.png', 'spine.tif'};

% Iterating through the each image to get main information about it
for i = 1:length(imArray)
    im = imArray{i};
    picture = imread(im);
    info = imfinfo(im);
    figure(i), imshow(picture);

    % checking for gray or rgb or indexed
    if isequal(info.ColorType, 'truecolor')
        isgray = false;
        isrgb = true;
        isind = false;
    elseif isequal(info.ColorType, 'grayscale')
        isgray = true;
        isrgb = false;
        isind = false;
    else isequal(info.ColorType, 'indexed')
        isgray = false;
        isrgb = false;
        isind = true;
    end


    % preparing string output using f-string
    txt1 = 'Params of image %d: \n isLogical: %d \n isGray: %d \n isRGB: %d \n isIndexed: %d';
    logic = islogical(picture);
    str = sprintf(txt1, i, logic, isgray, isrgb, isind);
    disp(str);
    txt2 = ' Image Info:';
    disp(txt2);
    disp(info);
end

% Examples of conversing images

    % RGB to Grayscaled with Sliced colors and jet-colormap
X = imread(imArray{1});
X_gray = rgb2gray(X);
X_ind = grayslice(X_gray, 8);
figure(4), 
subplot(311), imshow(X); title('Original image'); hold on;
subplot(312), imshow(X_gray); title('Grayscaled image'); hold on;
subplot(313), imshow(X_ind, jet(8)); title('8-colors colormap of grayscaled image'); hold on;

    % RGB to B&W
Y = imread(imArray{2});
Y_bw = im2bw(Y, 0.75);
figure(5),
subplot(211), imshow(Y); title('Original image'); hold on;
subplot(212), imshow(Y_bw); title('Black & White Conversion with 0.75-level'); hold on;


% Working with colormaps

[X_out1, map1] = gray2ind(X_gray, 3);
[X_out2, map2] = gray2ind(X_gray, 4);
[X_out3, map3] = gray2ind(X_gray, 5);

figure(6),
subplot(311), imshow(X_out1, map1); title('Indexed with 3 colors'); hold on;
subplot(312), imshow(X_out2, map2); title('Indexed with 4 colors'); hold on;
subplot(313), imshow(X_out3, map3); title('Indexed with 5 colors'); hold on;