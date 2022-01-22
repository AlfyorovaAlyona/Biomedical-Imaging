% NBE-E4000 Principles of Biomedical Engineering
% Template for Problem 1 of Exercise 1
%
% The example uses a three-shell head model made by me at MRC Cognition and
% Brain Sciences Unit, Cambridge, UK. The model was made using FLASH MR
% images, FreeSurfer, and MNE toolbox. If you would like to use this model
% for something that you wish to share or publish, please contact me.
%
% (c) Matti Stenroos 2016--2018, matti.stenroos@aalto.fi

clear
close all
% Put here the path of the folder, where you saved the plot
% functions that were shared in the Intro exercise. 
% You will need these functions also later.
plotfunctionpath='~/opetus/imaging/materials/plotroutines/';
addpath(plotfunctionpath);

% put here the full path to the attached model file
modelfile='~/opetus/imaging/materials/e1/eeg/e1_eegmodel';
load(modelfile,'m','noiseref','bmeshes','cmesh','L','eegsens');

% bmeshes:  triangle meshes for volume conductor model
%   cell array of structs that contain fields p, e, nop, noe (see below)
%
% cmesh:    cortical mesh, on which the sources are spanned; 8196 vertices
%   p: mesh vertices, [nop x 3] (source discretization points)
%   e: triangle description, [noe x 3] (indices to vertices)
%   nn:   cortical normal vector in each vertex, [nop x 3]
%   pinf: vertices for "inflated" mesh, [nop x 3] (commonly used for visualization)
%   curv: cortex curvature, [nop x 3] (commonly used for visualization)
%   nop: number of vertices, here 8196
%   noe: number of triangular elements, here 16384
%
% eegsens:  electrode positions and meshes for visualization; 70 electrodes
%   p:  electrode positions, [70 x 3]
%   mesh3d: mesh for 3D visualization of electrodes (p, e)
%   mesh2d: mesh for 2D visualization of electrodes (p, e)  
% L:        forward model, size(L) = (m,n) = (70 x 8196)
% m:        "measured" EEG, 100 time samples -> (70 x 100)
% noiseref: "measured" noise of the system, 200 samples -> (70 x 200)

%% This "%%" is a "block separator". Press ctrl-enter to run the code in blocks.
% first, demonstrate how spatial signals coming from a source atom look
% like & how to use the attached plot routines

sourceind=1623; % pick one source position from the brain
topodata=L(:,sourceind); %scalp potential due to 1 Am source current dipole
fscale=[-1 1]*max(abs(topodata)); %scale the plot
plotwidth=400;plotheight=300; % set plot size

set(figure(1),'position',[0 100 3*plotwidth plotheight],'name','topoexample');clf;
CreateAxes(1,3,1);hold on %make a plot window
    % plot cortical mesh and show source position & orientation::
    PlotMesh(cmesh,'facecolor',[.95 .95 .95],'facealpha',1);
    PlotPoints(cmesh.p(sourceind,:),'r.',15);
    PlotDipoles(cmesh.p(sourceind,:),.01*cmesh.nn(sourceind,:),1.5,0);
CreateAxes(1,3,2);hold on
    % plot resulting signal topography on 3D electrode mesh & add scalp
    PlotDataOnMesh(eegsens.mesh3d,L(:,sourceind),'caxis',fscale,...
        'colorbar',1,'colormap',15);
    PlotMesh(bmeshes{end});
CreateAxes(1,3,3);hold on
    % plot resulting signal topography on 3D electrode mesh & add scalp
    PlotEMEGTopo2D(eegsens.mesh2d,L(:,sourceind),'caxis',fscale,...
        'colorbar',1,'colormap',15); 
% save the picture
saveflag=0;
savescale=.75;
savedir='~/temp';
SaveCurrentFig(saveflag,savescale,savedir);
%%    
figure(2);clf; plot(m'); %plot the "measured" data as a "butterfly plot"
%add labels and set font sizes
fontsize_labels=14;
fontsize_axes=12;
xlabel('Time index','fontsize',fontsize_labels);
ylabel('Signal amplitude','fontsize',fontsize_labels);
set(gca,'fontsize',fontsize_axes);

% some tips for computing RMS...
m_rms=sqrt(mean(m.^2,2)); %compute RMS amplitude of the measurement for each channel
m_mrms=sqrt(mean(mean(m.^2,2))); %compute overall RMS amplitude of the measurement

%% OK, then just start working...
Nfp=size(L,1); % number of sensors ("field points")
Nsp=size(L,2); % number of sources ("source points")
[U,S,V]=svd(L,'econ'); % ...svd --- write "help svd" to learn more
sigma=diag(S); % singular values

figure(3);clf; plot(sigma,'ko'); % plot of the singular values...
fontsize_labels=14;
fontsize_axes=12;
xlabel('Component index','fontsize',fontsize_labels);
ylabel('Singular value','fontsize',fontsize_labels);
set(gca,'fontsize',fontsize_axes);



