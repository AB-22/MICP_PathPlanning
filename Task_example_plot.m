%% We plot how our Mixed integer program planned the path inside the convex
%regions subject to the previous conditions.

%exp_name='data_maze_3Rooms_2Corridors_12(sixbars)_10steps_VNEW';

% load("Folder_data_maze_3Rooms_2Corridors_6bars_Final\data_maze_3Rooms_2Corridors_6bars_Final_gapValue(0.005)\number_of_steps(12)\iteration_1_Outputs.mat")
load("Folder_data_maze_3Rooms_2Corridors_6bars_Final/data_maze_3Rooms_2Corridors_6bars_Final_gapValue(0.05)/number_of_steps(27)/iteration_1_Outputs.mat")


%load(['Folder_' exp_name '\' exp_name '_Outputs.mat']);

%load('Folder_data_maze_5Rooms_75config_25steps_finish5(g)\data_maze_5Rooms_75config_25steps_finish5(g)_Outputs_parameterValue(75).mat')
figure('Color', 'w', 'Name', 'Motion Task');
x=outputs.x;
V1=outputs.path.maze.V1;
V2=outputs.path.maze.V2;
V3=outputs.path.maze.V3;
V4=outputs.path.maze.V4;
V5=outputs.path.maze.V5;
% V6=outputs.path.maze.V6;
% V7=outputs.path.maze.V7;
% V8=outputs.path.maze.V8;
% V9=outputs.path.maze.V9;
% V10=outputs.path.maze.V10;
% V11=outputs.path.maze.V11;
start=outputs.path.start;
finish=outputs.path.finish;
number_of_steps=outputs.path.number_of_steps;
config_array=outputs.Drone.config_array;
num_of_configs=outputs.Drone.num_of_configs;
num_of_drone_vertices=outputs.Drone.num_of_drone_vertices;
s=outputs.s;
% Plot the steps and the three objects in 3D plot
% plot3((x(1,:))',(x(2,:))',(x(3,:))','o','MarkerEdgeColor','k','MarkerSize',6,...
% 'LineWidth',2); hold on;
% plot3(start(1),start(2),start(3),'s','MarkerEdgeColor','g','MarkerSize',10,...
% 'LineWidth',2); hold on;
% plot3(finish(1),finish(2),finish(3),'s','MarkerEdgeColor','r','MarkerSize',6,...
% 'LineWidth',2); hold on;

[~, in] = max(s);
% for k=1:number_of_steps
%     for j = 1:num_of_drone_vertices
%         plot3(x(1,k) + config_array(1, j, in(k)), ...
%               x(2,k) + config_array(2, j, in(k)), ...
%               x(3,k) + config_array(3, j, in(k)), ...
%               '*','MarkerEdgeColor','r','MarkerSize',2,...
%             'LineWidth',2); hold on;
% 
%         
%     end
% end

load('data_robot_SixBar_floating.mat');


for k=1:number_of_steps
   vis_Draw(robot,config_array(:,:,in(k))+x(:,k), 'RodsRadius', 0.02, 'NodeRadius', 0.04); 
end

%figure('Color', 'w')
% h = trisurf(K, V1(:, 1), V1(:, 2), V1(:, 3), 'EdgeAlpha', 0.05, 'FaceAlpha', 0.1, 'FaceColor', 'b', 'SpecularStrength', 0.2);

vis_Body(V1, 'FaceAlpha', 0.1, 'EdgeAlpha', 0.05, 'FaceColor', 'b'); hold on;
vis_Body(V2, 'FaceAlpha', 0.1, 'EdgeAlpha', 0.05, 'FaceColor', 'c'); 
vis_Body(V3, 'FaceAlpha', 0.1, 'EdgeAlpha', 0.05, 'FaceColor', 'b');
vis_Body(V4, 'FaceAlpha', 0.1, 'EdgeAlpha', 0.05, 'FaceColor', 'c'); 
vis_Body(V5, 'FaceAlpha', 0.1, 'EdgeAlpha', 0.05, 'FaceColor', 'b');
% vis_Body(V6, 'FaceAlpha', 0.4, 'EdgeAlpha', 0.05, 'FaceColor', 'c'); 
% vis_Body(V7, 'FaceAlpha', 0.4, 'EdgeAlpha', 0.05, 'FaceColor', 'b');
% vis_Body(V8, 'FaceAlpha', 0.4, 'EdgeAlpha', 0.05, 'FaceColor', 'c'); 
% vis_Body(V9, 'FaceAlpha', 0.4, 'EdgeAlpha', 0.05, 'FaceColor', 'b');
% vis_Body(V10, 'FaceAlpha', 0.4, 'EdgeAlpha', 0.05, 'FaceColor', 'c'); 
% vis_Body(V11, 'FaceAlpha', 0.4, 'EdgeAlpha', 0.05, 'FaceColor', 'b');


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

% grid on;
% grid minor;
drawnow;
% drawPolyFromVertices(V1,'b','FaceColor','b','FaceAlpha',.3,'EdgeAlpha',.3);
% hold on;
% drawPolyFromVertices(V2,'g','FaceColor','g','FaceAlpha',.3,'EdgeAlpha',.3);
% hold on;
% drawPolyFromVertices(V3,'r','FaceColor','r','FaceAlpha',.3,'EdgeAlpha',.3);
% hold on;
% Here is the plot of the configurations ( the marker of its vertices is  '^')
%fill3(P(1,:,1),P(2,:,1),P(3,:,1),'k-^', 'FaceAlpha', 1,'EdgeAlpha',.3);
% % % for i=1:num_of_configs
% % %     fill3(P(1,:,i),P(2,:,i),P(3,:,i),'k-^', 'FaceAlpha', 1,'EdgeAlpha',.3);
% % % end

axis equal