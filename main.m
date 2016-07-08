% magnitudes and tangents

I = double(imread('Test.png'))/255;
if size(I,3) > 1
    I = rgb2gray(I);
end
figure, imshow(I), title('input')

% 'positive' ridges, wavelet bank, 0...179
[~,~,RGB1] = matR(I,1);
figure, imshow(RGB1), title('positive ridges')

% 'negative' ridges, wavelet bank, 0...179
[~,~,RGB2] = matR(I,-1);
figure, imshow(RGB2), title('negative ridges')

% derivatives, wavelet bank, 0...359
[~,~,RGB3] = matI(I);
figure, imshow(RGB3), title('derivatives (wavelet bank)')

% derivatives, matlab's implementation, 0...359
[~,~,RGB4] = mmat(I);
figure, imshow(RGB4), title('derivatives, matlab implementation')

% derivatives, 2 wavelets (x and y directions), 0...359
[~,~,RGB5] = mat2(I);
figure, imshow(RGB5), title('derivatives, matlab with wavelets')

% ridges and derivatives, wavelet bank, 0...179
[~,~,RGB6] = matZ(I);
figure, imshow(RGB6), title('ridges and derivatives, wavelets')

% legend
[nr,nc] = size(I);
% Test = zeros(nr,nc);
L = zeros(nr,nc,3);
L(:,:,2) = 1;
r0 = nr/2;
c0 = nc/2;
l0 = min(size(I))/6;
l1 = 1.25*l0;
for a = 0:pi/16:2*pi-pi/16
    for l = l0:l1
        r = round(r0+l*cos(a));
        c = round(c0+l*sin(a));
        if l == l0
            L(r-1:r+1,c-1:c+1,1) = a/(2*pi);
            L(r-1:r+1,c-1:c+1,3) = 1;
        else
            L(r,c,1) = a/(2*pi);
            L(r,c,3) = 1;
        end
    end
end
L = hsv2rgb(L);
figure, imshow(L), title('legend (angles)')