% NBE-E4000 Principles of Biomedical Engineering
% Template for Problem 2 of Exercise 1
%
% The example uses thorax geometry models from ECGSIM software. The forward
% models were made using Helsinki BEM framework boundary element solvers.
% If you would like to use this kind of models for something please contact me!
%
% Matti Stenroos, matti.stenroos@aalto.fi

clear
close all
clc
% Put here the path of the folder, where you saved the plot functions that
% were given in the problem set.
plotfunctionpath='~/opetus/imaging/materials/plotroutines/';
addpath(plotfunctionpath);

% put here the full path to the attached model file
modelfile='~/opetus/imaging/materials/e1/ecg/e1_ecgmodel';
load(modelfile,'m','thorax', 'myocardium', 'pericardium', 'L_peri','L_myo');
% thorax:   triangle mesh for the thorax boundary (see problem 1)
% pericardium: smooth triangle mesh for the outer boundary of the heart
% myocardium: triangle mesh for the boundaries of the heart muscle
% L_epi:    forward model from the nodes of epicardial mesh to the nodes of thorax
% L_myo:    forward model from the nodes of myocardial mesh to the nodes of thorax
% m:        "measured" EEG, 1 time sample, on the whole thorax

%% This "%%" is a "block separator". Press ctrl-enter to run the code in blocks.
% First, show how the model looks like
figure(1);clf;hold on;
PlotMesh(myocardium,'facecolor',[1 .7 .7],'facealpha',.8);
PlotMesh(pericardium,'facecolor',[.7 .7 1],'facealpha',.4);
PlotMesh(thorax,'facecolor',[.8 .8 .8],'facealpha',.1);
% Show, where and how are the source atoms of L_peri and L_myo
pw=400;ph=400;
set(figure(2),'position',[0 100 2*pw ph]);clf;
CreateAxes(1,2,1);hold on
PlotMesh(pericardium,'facealpha',.7);
PlotDipoles(pericardium.p,pericardium.nn,1);
title('Sources atoms on pericardium');
CreateAxes(1,2,2);hold on
PlotMesh(myocardium,'facealpha',.7);
PlotDipoles(myocardium.p,myocardium.nn,1);
title('Source atoms on myocardium');

%% Then, show the data
figure(3);clf;
PlotDataOnMesh(thorax,m);
%% Then, form and use the inverse operators...
N_sensors=size(thorax.p,1);
% SNRperi=...;
% lambda2_peri=trace(L_peri*L_peri')...
% Linv_peri=L_peri'...
%     
% s_est_peri=Linv_peri*m;
