function [M,T,RGB] = matI(I)
    % magnitudes and tangents of grayscale, double, range [0,1] image I
    % M in [0,1], double
    % T in 0:359
    %     angles are measured counterclockwise from 'x' axis
    %     where 'x' is row and 'y' is column
    % RGB: representation of M and T (see lines 52-57 for interpretation)
    % Similar to mat.m, but wavelet outputs are vector-averaged instead of
    %     interpolated
    
    stretch = 0;
    scale = 1;
    npeaks = 1;

    n = 16;
    N = 360;

    [nr,nc] = size(I);

    J = zeros(nr,nc,n);

    orientations = 0:N/n:N-N/n;
    for i = 1:n
        orientation = orientations(i);
        mi = imorlet(stretch,scale,orientation,npeaks);
        J(:,:,i) = conv2(I,mi,'same');
    end

    M = zeros(nr,nc);
    T = zeros(nr,nc);
    for row = 1:nr
        for col = 1:nc
            x = zeros(2,n);
            for i = 1:n
                a = orientations(i)/N*2*pi; % 0 to 2*pi
                x(:,i) = J(row,col,i)*[cos(a); sin(a)];
            end
            mx = mean(x,2);
            nmx = norm(mx);
            M(row,col) = nmx;
            mx = mx/nmx;
            a = atan2(mx(2),mx(1))/pi*180; % -180 to 180;
            if a < 0
                a = a+360;
            end
            T(row,col) = a;
        end
    end
    M = M/max(max(M));
    
    if nargout > 2
        H = T/360;
        S = ones(nr,nc);
        V = M;

        HSV = cat(3,cat(3,H,S),V);
        RGB = hsv2rgb(HSV);
    end
end