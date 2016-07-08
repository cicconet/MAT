function mr = rmorlet(stretch,scale,orientation,npeaks)
    % controls width of gaussian window (default: scale)
    sigma = scale;

    % orientation (in radians)
    theta = -(orientation-90)/360*2*pi;

    % controls elongation in direction perpendicular to wave
    gamma = 1/(1+stretch);

    % width and height of kernel
    support = 2.5*sigma/gamma;

    % wavelength (default: 4*sigma)
    lambda = 1/npeaks*4*sigma;

    % phase offset (in radians)
    psi = 0;


    xmin = -support;
    xmax = -xmin;
    ymin = xmin;
    ymax = xmax;

    xdomain = xmin:xmax;
    ydomain = ymin:ymax;

    [x,y] = meshgrid(xdomain,ydomain);

    xprime = cos(theta)*x+sin(theta)*y;
    yprime = -sin(theta)*x+cos(theta)*y;

    expf = exp(-0.5/sigma^2*(xprime.^2+gamma^2*yprime.^2));

    mr = expf.*cos(2*pi/lambda*xprime+psi);

    % mean = 0
    mr = mr-sum(sum(mr))/numel(mr);

    % norm = 1
    mr = mr./sqrt(sum(sum(mr.*mr)));
end