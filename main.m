% magnitudes and tangents

I = double(imread('C1.png'));

% wavelet bank (arbitrary size)
tic
[~,~,RGB1] = mat(I);
t1 = toc;

% matlab's implementation
tic
[~,~,RGB2] = mmat(I);
t2 = toc;

% 2 wavelets (x and y directions)
tic
[~,~,RGB3] = mat2(I);
t3 = toc;

% legend
[nr,nc] = size(I);
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

% separation
S = 0.5*ones(nr,5,3);

% plot
imshow([RGB1 S RGB2 S RGB3 S L])
title(sprintf('mat (%f s) ... mmat (%f s) ... mat2 (%f s) ... color/tangent mapping', t1, t2, t3))