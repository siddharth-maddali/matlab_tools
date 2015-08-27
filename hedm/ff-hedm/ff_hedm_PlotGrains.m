clear all
close all
clc

%%% FIRST RUN : startup_mtex.m IF IPF COLORBAR NEEDED

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%v
%%% GENERATE IPF COLORMAP USING MTEX
%%% CHECK IN ebsdColorbar.m
% cs  = symmetry('m-3m');
% ss  = symmetry('-1');
% cc  = get_option('antipodal','colorcoding','ipdfHKL');

% [minTheta,maxTheta,minRho,maxRho,v] = getFundamentalRegionPF(cs, 'antipodal');
% h   = S2Grid('PLOT', 'minTheta', minTheta, 'maxTheta', maxTheta,...
%     'minRho', minRho, 'maxRho', maxRho, 'RESTRICT2MINMAX', 'resolution', 1*degree, 'antipodal');
% v   = vector3d(h);
% x   = getx(v); x = x(:);
% y   = gety(v); y = y(:);
% z   = getz(v); z = z(:);
% d   = orientation2color(h,cc,cs,'antipodal');
% save('coloring_scheme.mat', 'x', 'y', 'z', 'd')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% User Input
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wsname  = 'wscub4x';      % workspace name
pname   = './examples/';
fname   = 'Grains_example.csv';

% ROTATION MATRIX TAKING VECTOR IN LAB FRAME TO SAMPLE FRAME
% NECESSARY TO GET THE ORIENTATION OF CRYSTALS WITH RESPECT TO SAMPLE FRAME
RLab2Sam    = eye(3,3);

% FILTERS
Thresh_Completeness = 0.7;
Thresh_MeanRadius   = 50;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Execution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Load workspace for fundamental region.
load(wsname);
eval(['ws = ', wsname, ';']);
clear(wsname)

% Load MIDAS results
pfname  = fullfile(pname, fname);
Grains  = parseGrainData(pfname, ws.frmesh.symmetries);
numpts  = length(Grains);
wts     = ones(1, numpts);

% THRESHOLDING BY COMPLETENESS
idx_Completeness    = [Grains.Completeness] >= Thresh_Completeness;
idx_MeanRadius      = [Grains.MeanRadius] >= Thresh_MeanRadius;
idx = idx_Completeness;

% nGrains     = size(grains, 1);
% for i = 1:1:nGrains
%     RMats(:,:,i)   =  RESRF2APS*reshape(grains(i,2:10), 3, 3)';
% end
% qsym    = CubSymmetries; Rsym    = RMatOfQuat(qsym);
% quat    = ToFundamentalRegionQ(QuatOfRMat(RMats), qsym);
% rod     = RodOfQuat(quat);
% 
% xyz = RESRF2APS*[grains(:,11) grains(:,12) grains(:,13)]';
% xyz = xyz';

% load('.\coloring_scheme.mat');
% ori     = orientation('quaternion', quat(1,:), quat(2,:), quat(3,:), quat(3,:), cs);
% ebsd    = EBSD(ori, cs, ss);
% rgb     = orientation2color(ori, 'ipdfHSV');
% 
% plot(ebsd, 'colorcoding','ipdfHSV')

xyz = [Grains(idx).COM]';

%%%% PLOT COM / ONE COLOR
figure, scatter3(xyz(:,1), xyz(:,2), xyz(:,3), 30, 'filled', 'b')
grid on; axis square
xlabel('z : +=along beam (um)'); ylabel('x : +=OB (um)'); zlabel('y : +=UP (um)')
title('COM of found grains')

%%%% PLOT COM / COMPLETENESS AS COLOR
figure, scatter3(xyz(:,1), xyz(:,2), xyz(:,3), 30, [Grains(idx).Completeness], 'filled')
grid on; axis square
colorbar vert; caxis([0.5 1])
xlabel('z : +=along beam (um)'); ylabel('x : +=OB (um)'); zlabel('y : +=UP (um)')
title('COM of found grains // colors denote completeness')

%%%% PLOT COM / RGB IN FUNDAMENTAL TRIANGLE AS IPDF
% figure, scatter3(grains(:,11), grains(:,12), grains(:,13), 50, rgb, 'filled') %% COMPLETENESS
% grid on
% axis square
return
%%%% PLOT ORIENTATIONS / ONE COLOR
figure, PlotFRPerimeter('cubic');
scatter3(rod(1,:), rod(2,:), rod(3,:), 50, 'filled', 'b')
axis square tight off

%%%% PLOT ORIENTATIONS / COMPLETENESS AS COLOR
figure, PlotFRPerimeter('cubic');
scatter3(rod(1,:), rod(2,:), rod(3,:), 50, grains(:,24), 'filled')
axis square tight off
colorbar vert

% %%%% PLOT ORIENTATIONS / RGB IN FUNDAMENTAL TRIANGLE AS IPDF
% figure, PlotFRPerimeter('cubic');
% scatter3(rod(1,:), rod(2,:), rod(3,:), 50, rgb, 'filled')
% axis square tight off

%%%% HISTOGRAM OF GRAIN SIZES NORMALIZED BY MAX GRAIN SIZE
figure, hist(grains(:,23)./max(grains(:,23)), 20)
xlabel('relative grain radius (-)')
ylabel('number of grains (-)')
title(sprintf('Max grain size : %5.0f (micron)', max(grains(:,23))))
axis([0 1 0 80])

figure, 
subplot(2,3,1)
hist(grains(:,14))
xlabel('a (Angstrom)')
ylabel('number of grains (-)')
title(sprintf('a0 = %5.4f A', a0))
view([0 90])
axis([3.58 3.61 0 150])
grid on

subplot(2,3,2)
hist(grains(:,15))
xlabel('b (Angstrom)')
ylabel('number of grains (-)')
title(sprintf('a0 = %5.4f A', a0))
view([0 90])
axis([3.58 3.61 0 150])
grid on

subplot(2,3,3)
hist(grains(:,16))
xlabel('c (Angstrom)')
ylabel('number of grains (-)')
title(sprintf('a0 = %5.4f A', a0))
view([0 90])
axis([3.58 3.61 0 150])
grid on

subplot(2,3,4)
hist(grains(:,17))
xlabel('\alpha (degrees)')
ylabel('number of grains (-)')
view([0 90])
axis([89.7 90.3 0 150])
grid on

subplot(2,3,5)
hist(grains(:,18))
xlabel('\beta (degrees)')
ylabel('number of grains (-)')
view([0 90])
axis([89.7 90.3 0 150])
grid on

subplot(2,3,6)
hist(grains(:,19))
xlabel('\gamma (degrees)')
ylabel('number of grains (-)')
view([0 90])
axis([89.7 90.3 0 150])
grid on