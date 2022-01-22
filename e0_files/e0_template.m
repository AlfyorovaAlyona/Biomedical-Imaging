%% A template for the stereoscopy exercise.
% Lari Koponen & Matti Stenroos 2016--2018

%% Read and show and image:
image_left = imread('C1.jpg'); % Read an image from a file
h1=figure(1); % Create a new figure.
clf;
imagesc(image_left); % Plot an image.
axis('equal'); % Do not distort x and y axes.

% For capturing the pixel coordinates ginput() might be useful. Use of ginput()
% is easier, if you make the image a bit larger:
% set(h1,'position',[0 100 1400 900])
%% Define the camera coordinate systems.

% The camera positions, r{1} and r{2}.
r = {[ ...
   -0.0509
   -0.0068
   -0.0113
], [
    0.0514
    0.0149
    0.0034
]};

% The camera orientations given in Cartesian coordinate system.
% R=[e_x e_y e_z], where e_i is the i:th coordinate axis expressed in some
% other cartesian system (in this case, the world coordinates).
R = {[ ...
    0.9955    0.0221   -0.0921
    0.0063    0.9549    0.2968
    0.0945   -0.2961    0.9505
], [ ...
    0.9784   -0.0641    0.1967
   -0.0047    0.9436    0.3311
   -0.2068   -0.3249    0.9229
]};

%% Plot the camera locations and coordinate axes using given Matlab routines
% Save the plot routines to some directory (preferably not the one, where
% you have this script) and set it to your Matlab path. We will use the
% same routines in later exercises, too.
% The plot routines assume 3D points given as row vectors, but this
% exercise (and coordinate transforms in general) use column vectors, so
% we'll have to transpose.
%% Plot camera systems in world coordinates
figure(2);clf;hold on

PlotPoints(r{1}','ro',10);
PlotDipoles([r{1} r{1} r{1}]',.02*R{1}',1,0);

PlotPoints(r{2}','bo',10);
PlotDipoles([r{2} r{2} r{2}]',.02*R{2}',1,0);
axis equal
