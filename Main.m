% ### Description ###
%{
This Main.m file is used to generate the results of a new experiment
OR to plot the results of a previous experiment In the plot section
(just change the exp_name and your other parameters), or you can show the plots of a presaved (file.mat) of results
in the section of plotting beneath.
 Each exp_name refers to a folder that will be created and all results can
 be found in that folder.
%}


%{
 You can use the section of generating new Configurations to generate
 Drone configurations within specified number of configurations and a name
 for the generated dataset of configurations.

However, there is a pre-stored datasets you can load and use in the solving
section.
%}


%{
    For the Solving section, You put the name of the experiment
    then enter the name of the Drone Configurations dataset that you wish
    to load from the Configs folder.


%}

%NOTE: these has to be on top
clear;
close all;
clc;



%% Solving Section and save the results in the corresponding folder

steps_values=[3 5 7 10 12 15 18 20 25 27];
gap_values=[0.05 0.02 0.005];
num_of_exps=10;
exp_name='data_maze_3Rooms_2Corridors_6bars_Final'; % Experiment name
config_name='Sixbar_Drone_12vertices_8configs_NEW_V4'; % The name of the configuratons dataset you want to load
load(['Configs_Folder\' config_name '.mat']);
number_of_regions=5; % the number of the convex regions (including rooms and corridors)
T_cubes=zeros(3,3,number_of_regions); %T_cubes is 3x3xnumber_of_cubes(rooms&corridors) it express the convex regions

%{
 if you want to change the number_of_regions you should  edit Generate_inputs function.
Then edit the plot section for presenting the new number of rooms.
%}
cubes_centers=zeros(3,1,number_of_regions); % Here we initate the cubes_center for generating the rooms

mkdir (['Folder_' exp_name]); % Create a new folder for the Our experiment

T_cubes(:,:,1) = [0.5*4.5 0 0;0 0.5*3 0;0 0 0.5*3.5];
cubes_centers(:,:,1)=[3.5;0; 0];

T_cubes(:,:,2) = [5 0 0;0 0.5*0.5 0;1 0 0.5*0.5];
cubes_centers(:,:,2)=[10.5;0; 0];

T_cubes(:,:,3)= [0.5*4.5 0 0;0 0.5*3 0;0 0 0.5*3.5];
cubes_centers(:,:,3)=[17;0; 0];

T_cubes(:,:,4)= [5 0 0;0 0.5*0.7 0;1 0 0.5*0.7];
cubes_centers(:,:,4)=[24;0; 0];

T_cubes(:,:,5)= [0.5*4.5 0 0;0 0.5*3 0;0 0 0.5*3.5];
cubes_centers(:,:,5)=[30.5;0; 0];   % Here is the end of 5 convex regions, if more we should add as commented below

%{
Generating the inputs file that produces the convex regions from the
vertices to h-polytop presentation.

The Inputs.mat file will be generated inside the experiment folder.
that file includes V-presentation in struct 'maze' for the convex regions
and H-presentation of the convex regions and their intersections.'

This function should be edited if we changed the number of convex regions.
%}
inputs= Generate_inputs(exp_name,T_cubes,cubes_centers); 

% Planning steps,start and finish points
start=sum(inputs.maze.V1,2)/size(inputs.maze.V1,2)-0.3*ones(3,1); % start point is at the center of the 1st room
finish=sum(inputs.maze.V5,2)/size(inputs.maze.V5,2)+0.25*ones(3,1);% finish point is at the center of the 2nd corridor

% Parameters of the mixed integer program
weight_goal=220; % the weight of the goal in the objective function
bigM=30;       % big M for the mixed integer program

%{
Generate_outputs() is a function that takes pregenerated Inputs , start/finish points
 , Drone Configurations dataset, experiment name, bigM, goal weight, number
 of steps, number of convex regions.

Then, in this function we solve our optimiztion problem (which is described
inside the function) and save the results in 'Outputs.mat' saved in the
folder of the experiment.

Inside the function, you can see commented lines of code, like when getting
the values of H-presentation of the convex regions, those commented lines
are for facilating the process of adding more rooms, because we have to
edit the function there.
%}
for i=1:length(gap_values)
    gap_val=gap_values(i);
    for j=1:length(steps_values)
        number_of_steps=steps_values(j); % number of the steps taken by the drone from start to finish point 
        for k=1:num_of_exps
            exp_num=k;
            outputs=Generate_outputs(exp_name,inputs,number_of_regions,start,finish,...
            number_of_steps,weight_goal,bigM,configs,gap_val,exp_num);
        end
    end
end


