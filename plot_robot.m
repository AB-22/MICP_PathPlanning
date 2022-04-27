close all; clear;

load('data_robot_SixBar_floating.mat')

figure('Color', 'w');

h = vis_Draw2(robot, robot.nodes_position, 'RodsRadius', 0.01, 'NodeRadius', 0.02);

h.rods(1).FaceColor = [0 0.7 0];
h.rods(2).FaceColor = [0 0.7 0];

hold on;
ax = gca;
ax.GridAlpha = 0.1;
ax.LineWidth = 0.01;
% ax.MinorGridLineStyle = '-';
% ax.MinorGridAlpha = 0;
ax.FontName = 'Tibetan Machine Uni';
ax.FontSize = 18;
xlabel_handle = xlabel('$$x$$');
xlabel_handle.Interpreter = 'latex';
ylabel_handle = ylabel('$$y$$');
ylabel_handle.Interpreter = 'latex';
zlabel_handle = zlabel('$$z$$');
zlabel_handle.Interpreter = 'latex';

axis equal