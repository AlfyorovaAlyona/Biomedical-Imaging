% NBE-E4000 Exercise 2 data template
% v211007 (c) Matti Stenroos
clear
% put here the path, where you saved the data
datapath='d:/share/PBI/materials/e2/e2_dataset';
vars={'Lmeg','Leeg','brainmesh','sourceposinds','scalpmesh','timecourses','timecourseinfo',...
    'coilinfo','elecinfo'};
load(datapath,vars{:});

% Lmeg: lead field matrix, 102 magnetometers, 20002 source atoms 
%        (normally-oriented unit-amplitude dipoles in the brain)
% sourceposinds: description of source pairs, indices to columns of Lfull.
% sourceposinds =
% 
%         3768        1173
%         3768        1975
%         3768        4614
%         3768        4274
%   source with index 3768 is in this exercise called the "seed source",
%   and the other sources here are "test sources". Each row of this array
%   forms a source pair, containing the seed source and a test source.
%
% brainmesh: brain geometry. Source atoms are in the vertices of this mesh,
%   oriented in normal direction
%   brainmesh.e:  vertices
%   brainmesh.e:  triangle description
%   brainmesh.nn: vertice normals (= orientations of source atoms)
%
% scalpmesh: scalp geometry, may be useful
% coilinfo:  MEG coil locations and orientations & visualization meshes.
%   coilinfo.mesh2d: 2D visualization mesh to be used with PlotEMEGTopo2D
%   coilinfo.mesh3d: 3D visualization mesh to be used with PlotDataOnMesh
%   coilinfo.p:      positions of coil centers in 3D
%   coilinfo.n:      normal vectors of coils (3D) ~ sensing direction
%
% timecourses: cell array, where each cell contains one pair of time courses
% timecourseinfo: cell array, a bit of info on the time courses
%
% The brain mesh and scalp mesh are extracted from SimNIBS sample data set 
% "Ernie", which is shared under GPL license. If you would like to use
% these meshes for something else, please contact matti.stenroos@aalto.fi

%% example plot: lead field, topography, anatomy
Lfull = Lmeg;
sensormesh3d = coilinfo.mesh3d;
sensormesh2d = coilinfo.mesh2d;

sourceindex = 3768;
texample = Lfull(:,sourceindex);
[~, sensorind] = max(texample);
lexample = Lfull(sensorind,:);

cscale = max(abs(lexample));
cmap = ColormapTurbo(11);
inflatedflag = false;
Ncols = 3; Nrows = 1;

% Let's make a nice figure. Tune the size, spacing and font.
plotwidth = 500;plotheight = 350;
set(figure(1),'position',[0 50 Ncols*plotwidth,Nrows*plotheight],'name','leadfield_and_topography');clf;
ha(1) = CreateAxes(1,Ncols,1,.1,[0 .05]);hold on;
    PlotDataOnMesh(brainmesh,lexample,'colormap',cmap,'caxis',cscale,'inflated',inflatedflag);
    PlotMesh(sensormesh3d,'facecolor',[.8 .8 .8],'facealpha',.1);    
    PlotPoints(sensormesh3d.p(sensorind,:),'k.',20);
    PlotPoints(brainmesh.p(sourceindex,:),'w.',20);
ha(2) = CreateAxes(1,Ncols,2,.1,[0 .05]);hold on;
    PlotMesh(scalpmesh,'facecolor',[.8 .8 .8]);
    PlotDataOnMesh(sensormesh3d,texample,'colormap',cmap,'caxis',cscale);
    PlotPoints(sensormesh3d.p(sensorind,:),'k.',20);
ha(3) = CreateAxes(1,Ncols,3,.1,[0 .05]);hold on;
    PlotEMEGTopo2D(sensormesh2d,texample,'colormap',cmap,'caxis',cscale);
    PlotPoints(sensormesh2d.p(sensorind,:),'k.',20);
set(ha,'fontsize',12)
%% example plot: time series
plotwidth = 500;plotheight = 400;
Nrows = 2;Ncols = 2;
set(figure(2),'position',[0 50 Ncols*plotwidth Nrows*plotheight],'name','timecourse example');clf;
for I=1:4
    CreateAxes(Nrows,Ncols,I,.2);
    tcthis = timecourses{I};
    tcinfothis = timecourseinfo{I};
    hp = plot(tcthis'); %our data is row-major, while Matlab assumes column-major
    set(hp(1),'color','r','linestyle','-');
    set(hp(2),'color','b','linestyle','--');
    legend({'tc 1', 'tc 2'},'fontsize',12);
    title(tcinfothis);
    set(gca,'ylim',[-1.2 1.2]);
    set(gca,'fontsize',12);
end
