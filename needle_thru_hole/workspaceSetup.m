%% workspaceSetup.m

% This is the script to setup the workspace of needle thru hole problem.
% What included in the script is the parameters that describe a 2D planar
% tissue block with a hole in the middle.

%% Parameters
tissue = [-25  25  25 -25 -25; 25 25 -25 -25 25];
%tissue=[1 1;1 1];
structTissueData =struct('center',[0; -10; 0],'widthX',[30],'heightZ',[10],'depthY',[10]);

wall_top = [-2 -2 2 2;25 5 5 25];
wall_bottom = [-2 -2 2 2;-25 -5 -5 -25];

clf;
axis([-50 50 -50 50]);
axis square;

%% Plot the box.
line(tissue(1,:),tissue(2,:),'color','blue');
line(wall_top(1,:),wall_top(2,:),'color','blue');
line(wall_bottom(1,:),wall_bottom(2,:),'color','blue');

%% Needle Type 3. non ideal curved Needle
structNeedleGeometry = struct('straightL',0,'kinkAngle', 0, 'radius',10,'arc',pi);

%% initial transformation matrix (initial configuration)
needle_tip_pos_init = [-10;0;0]; % the initial need tip position wrt spatial frame

transMatFrmNeedleToTissue.rot = [-1 0 0;0 1 0;0 0 -1]; % the initial need frame orientation
transMatFrmNeedleToTissue.trans = needle_tip_pos_init - transMatFrmNeedleToTissue.rot * structNeedleGeometry.radius * [-1 0 0]';

%% test checkCollision
% define the boundry of the map
mapUpBound = struct('start',[-50; 50; 0],'end',[50; 50; 0]);
mapLefeBound = struct('start',[50; 50; 0],'end',[50; -50; 0]);
mapBottomBound = struct('start',[50; -50; 0],'end',[-50; -50; 0]);
mapRightBound = struct('start',[-50; -50; 0],'end',[-50; 50; 0]);

% define the boundry of the objects
% top wall
topWallRight = struct('start',[-5; 5; 0],'end',[-5; 50; 0]);
topWallLeft = struct('start',[5; 5; 0],'end',[5; 50; 0]);
topWallBottom = struct('start',[-5; 5; 0],'end',[5; 5; 0]);
% bottom wall
downWallRight = struct('start',[-5; -5; 0],'end',[-5; -50; 0]);
downWallLeft = struct('start',[5; -5; 0],'end',[5; -50; 0]);
downWallBottom = struct('start',[-5; -5; 0],'end',[5; -5; 0]);

checkCollision( structStraightLine, structNeedleGeometry, transMatFrmNeedleToTissue);
    
    
    
    
    
    
    
    
    
    
    
    
    