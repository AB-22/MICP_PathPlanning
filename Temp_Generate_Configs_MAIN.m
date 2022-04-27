%% Generate Drone Configurations Dataset
   % ( this is just optional, in case you want to generate new dataset)
n=3; % 3D case
num_of_configs=8; % Number of Configurations

config_name='Sixbar_Drone_12vertices_8configs_NEW_V5'; % Name of the configurations dataset

% Calling the function that generates the required number of bounded random-sized configurations 

% Non realistic cubic tensodrone

% num_of_drone_vertices=8; % Number of Drone vertices (Initial suggestion)
% configs=Generate_configurations(n, num_of_configs, num_of_drone_vertices ,config_name);

% Realistic Sixbar tensodrone
configs=Generate_SixbarDrone_configurations_v2(n,num_of_configs,config_name);

%% Plot Configurations
config_name='Sixbar_Drone_12vertices_8configs_NEW_V4'; % The name of the configuratons dataset you want to load
load(['Configs_Folder\' config_name '.mat']);
for k=1:size(configs,2)
   figure(k)
   vis_Draw(configs(k),configs(k).nodes_position); 
end

%% Check Rest Lenghts
config_name='Sixbar_Drone_12vertices_8configs_NEW_V4'; % The name of the configuratons dataset you want to load
load(['Configs_Folder\' config_name '.mat']);

for k=1:size(configs,2)
    rho(1,k)=norm(configs(k).nodes_position(:,1)-configs(k).nodes_position(:,5));
    rho(2,k)=norm(configs(k).nodes_position(:,1)-configs(k).nodes_position(:,6));
    rho(3,k)=norm(configs(k).nodes_position(:,1)-configs(k).nodes_position(:,9));
    rho(4,k)=norm(configs(k).nodes_position(:,1)-configs(k).nodes_position(:,11));
    
    rho(5,k)=norm(configs(k).nodes_position(:,2)-configs(k).nodes_position(:,7));
    rho(6,k)=norm(configs(k).nodes_position(:,2)-configs(k).nodes_position(:,8));
    rho(7,k)=norm(configs(k).nodes_position(:,2)-configs(k).nodes_position(:,9));
    rho(8,k)=norm(configs(k).nodes_position(:,2)-configs(k).nodes_position(:,11));
    
    rho(9,k)=norm(configs(k).nodes_position(:,3)-configs(k).nodes_position(:,5));
    rho(10,k)=norm(configs(k).nodes_position(:,3)-configs(k).nodes_position(:,6));
    rho(11,k)=norm(configs(k).nodes_position(:,3)-configs(k).nodes_position(:,10));
    rho(12,k)=norm(configs(k).nodes_position(:,3)-configs(k).nodes_position(:,12));
    
    rho(13,k)=norm(configs(k).nodes_position(:,4)-configs(k).nodes_position(:,7));
    rho(14,k)=norm(configs(k).nodes_position(:,4)-configs(k).nodes_position(:,8));
    rho(15,k)=norm(configs(k).nodes_position(:,4)-configs(k).nodes_position(:,10));
    rho(16,k)=norm(configs(k).nodes_position(:,4)-configs(k).nodes_position(:,12));
    
    
    rho(17,k)=norm(configs(k).nodes_position(:,5)-configs(k).nodes_position(:,1));
    rho(18,k)=norm(configs(k).nodes_position(:,5)-configs(k).nodes_position(:,3));
    rho(19,k)=norm(configs(k).nodes_position(:,5)-configs(k).nodes_position(:,9));
    rho(20,k)=norm(configs(k).nodes_position(:,5)-configs(k).nodes_position(:,10));
    
    rho(21,k)=norm(configs(k).nodes_position(:,6)-configs(k).nodes_position(:,1));
    rho(22,k)=norm(configs(k).nodes_position(:,6)-configs(k).nodes_position(:,3));
    rho(23,k)=norm(configs(k).nodes_position(:,6)-configs(k).nodes_position(:,11));
    rho(24,k)=norm(configs(k).nodes_position(:,6)-configs(k).nodes_position(:,12));
    
    
    rho(25,k)=norm(configs(k).nodes_position(:,7)-configs(k).nodes_position(:,2));
    rho(26,k)=norm(configs(k).nodes_position(:,7)-configs(k).nodes_position(:,4));
    rho(27,k)=norm(configs(k).nodes_position(:,7)-configs(k).nodes_position(:,9));
    rho(28,k)=norm(configs(k).nodes_position(:,7)-configs(k).nodes_position(:,10));
    
    rho(29,k)=norm(configs(k).nodes_position(:,8)-configs(k).nodes_position(:,2));
    rho(30,k)=norm(configs(k).nodes_position(:,8)-configs(k).nodes_position(:,4));
    rho(31,k)=norm(configs(k).nodes_position(:,8)-configs(k).nodes_position(:,11));
    rho(32,k)=norm(configs(k).nodes_position(:,8)-configs(k).nodes_position(:,12));
    
    
    rho(33,k)=norm(configs(k).nodes_position(:,9)-configs(k).nodes_position(:,1));
    rho(34,k)=norm(configs(k).nodes_position(:,9)-configs(k).nodes_position(:,2));
    rho(35,k)=norm(configs(k).nodes_position(:,9)-configs(k).nodes_position(:,5));
    rho(36,k)=norm(configs(k).nodes_position(:,9)-configs(k).nodes_position(:,7));
    
    
    rho(37,k)=norm(configs(k).nodes_position(:,10)-configs(k).nodes_position(:,3));
    rho(38,k)=norm(configs(k).nodes_position(:,10)-configs(k).nodes_position(:,4));
    rho(39,k)=norm(configs(k).nodes_position(:,10)-configs(k).nodes_position(:,5));
    rho(40,k)=norm(configs(k).nodes_position(:,10)-configs(k).nodes_position(:,7));
    
    rho(41,k)=norm(configs(k).nodes_position(:,11)-configs(k).nodes_position(:,1));
    rho(42,k)=norm(configs(k).nodes_position(:,11)-configs(k).nodes_position(:,2));
    rho(43,k)=norm(configs(k).nodes_position(:,11)-configs(k).nodes_position(:,6));
    rho(44,k)=norm(configs(k).nodes_position(:,11)-configs(k).nodes_position(:,8));
    
    rho(45,k)=norm(configs(k).nodes_position(:,12)-configs(k).nodes_position(:,3));
    rho(46,k)=norm(configs(k).nodes_position(:,12)-configs(k).nodes_position(:,4));
    rho(47,k)=norm(configs(k).nodes_position(:,12)-configs(k).nodes_position(:,6));
    rho(48,k)=norm(configs(k).nodes_position(:,12)-configs(k).nodes_position(:,8));
    
    
    
end

for i=1:size(rho,1)
    for j=1:size(rho,2)
        if round(rho(i,j),1)~=0.3
            error('Cable rest lengths changed!')
        end
    end
end

%%  Test converting confings from struct to array

for k=1:size(configs,2)
 configs_Array(:,:,k)=configs(k).nodes_position;
end

%% Maze shape test
scale=0;

T_cubes(:,:,1) = [0.5*4.5 0 0;0 0.5*3 0;0 0 0.5*3.5];
cubes_centers(:,:,1)=[3.5;0; 0];

T_cubes(:,:,2) = [5 0 0;0 0.5*0.7 0;1 0 0.5*0.7];
cubes_centers(:,:,2)=[10.5;0; 0];

T_cubes(:,:,3)= [0.5*4.5 0 0;0 0.5*3 0;0 0 0.5*3.5];
cubes_centers(:,:,3)=[17;0; 0];

T_cubes(:,:,4)= [5 0 0;0 0.5*0.7 0;1 0 0.5*0.7];
cubes_centers(:,:,4)=[24;0; 0];

T_cubes(:,:,5)= [0.5*4.5 0 0;0 0.5*3 0;0 0 0.5*3.5];
cubes_centers(:,:,5)=[30.5;0; 0];

V = Generate_path(T_cubes,cubes_centers);

V1 = V(:,:,1);
V2 = V(:,:,2);
V3 = V(:,:,3);
V4 = V(:,:,4);
V5 = V(:,:,5);

[A1,b1] = vert2con(V1');
[A2,b2] = vert2con(V2');
[A3,b3] = vert2con(V3');
[A4,b4] = vert2con(V4');
[A5,b5] = vert2con(V5');



vis_Body(V1, 'FaceAlpha', 0.25, 'EdgeAlpha', 0.05, 'FaceColor', 'b'); hold on;
vis_Body(V2, 'FaceAlpha', 0.25, 'EdgeAlpha', 0.05, 'FaceColor', 'c'); 
vis_Body(V3, 'FaceAlpha', 0.25, 'EdgeAlpha', 0.05, 'FaceColor', 'b');
vis_Body(V4, 'FaceAlpha', 0.25, 'EdgeAlpha', 0.05, 'FaceColor', 'c'); 
vis_Body(V5, 'FaceAlpha', 0.25, 'EdgeAlpha', 0.05, 'FaceColor', 'b');


%% Orginal Maze
scale=1;

T_cubes(:,:,1) = [4.5 0 3;0 3 0;0 2 6];
cubes_centers(:,:,1)=[3.5;0; 0];

T_cubes(:,:,2) = [8 0 0.5;2 1.5*scale 0;0 0 1.5*scale];
cubes_centers(:,:,2)=[9.25;0; 0];

T_cubes(:,:,3)= [4 0 2;1 5 0;0 2 6];
cubes_centers(:,:,3)=[19;0; 0];

T_cubes(:,:,4)= [8 0 -2;0 1.5*scale 0;-2 0 1.5*scale];
cubes_centers(:,:,4)=[28.75;0; 0];

T_cubes(:,:,5)= [4 1 0;-2 5 0;0 0 6];
cubes_centers(:,:,5)=[37;0; 0];