function inputs= Generate_inputs(exp_name,T_cubes,cubes_centers)
% Description of Generate_inputs function
% This function generate the arrays that express each room in the maze
% exp_name is experiment name
% T_cubes is the array that express rooms dimensions
% cubes_centers is the array that express rooms centers
V = Generate_path(T_cubes,cubes_centers);
%scale =0.3;
%V=scale*V;
maze.V1 = V(:,:,1);
maze.V2 = V(:,:,2);
maze.V3 = V(:,:,3);
maze.V4 = V(:,:,4);
maze.V5 = V(:,:,5);
% maze.V6 = V(:,:,6);
% maze.V7 = V(:,:,7);
% maze.V8 = V(:,:,8);
% maze.V9 = V(:,:,9);
% maze.V10 = V(:,:,10);
% maze.V11 = V(:,:,11);
%A= zeros(length(temp(:,1)),3,length(T_cubes));
%b= zeros(length(temp(:,1)),1,length(T_cubes));
[A1,b1] = vert2con(maze.V1');
[A2,b2] = vert2con(maze.V2');
[A3,b3] = vert2con(maze.V3');
[A4,b4] = vert2con(maze.V4');
[A5,b5] = vert2con(maze.V5');
% [A6,b6] = vert2con(maze.V6');
% [A7,b7] = vert2con(maze.V7');
% [A8,b8] = vert2con(maze.V8');
% [A9,b9] = vert2con(maze.V9');
% [A10,b10] = vert2con(maze.V10');
% [A11,b11] = vert2con(maze.V11');

A12 = [A1; A2];
A23 = [A2; A3];
A34 = [A3; A4];
A45 = [A4; A5];
% A56 = [A5; A6];
% A67 = [A6; A7];
% A78 = [A7; A8];
% A89 = [A8; A9];
% A910 = [A9; A10];
% A1011 = [A10; A11];

b12 = [b1; b2];
b23 = [b2; b3];
b34 = [b3; b4];
b45 = [b4; b5];
% b56 = [b5; b6];
% b67 = [b6; b7];
% b78 = [b7; b8];
% b89 = [b8; b9];
% b910 = [b9; b10];
% b1011 = [b10; b11];

inputs=struct('A1',A1,'A2',A2,'A3',A3,'A4',A4,'A5',A5,...
        'A12',A12,'A23',A23,'A34',A34,'A45',A45,...
        'b1',b1,'b2',b2,'b3',b3,'b4',b4,'b5',b5,...
        'b12',b12,'b23',b23,'b34',b34,'b45',b45,...
        'maze',maze);


% inputs=struct('A1',A1,'A2',A2,'A3',A3,'A4',A4,'A5',A5,'A6',A6,...
%         'A7',A7,'A8',A8,'A9',A9,s'A10',A10,'A11',A11,...
%         'A12',A12,'A23',A23,'A34',A34,'A45',A45,'A56',A56,'A67',A67,...
%         'A78',A78,'A89',A89,'A910',A910,'A1011',A1011,...
%         'b1',b2,'b2',b2,'b3',b3,'b4',b4,'b5',b5,'b6',b6,'b7',b7,'b8',b8,...
%         'b9',b9,'b10',b10,'b11',b11,...
%         'b12',b12,'b23',b23,'b34',b34,'b45',b45,'b56',b56,'b67',b67,...
%         'b78',b78,'b89',b89,'b910',b910,'b1011',b1011,'maze',maze);
    
save(['Folder_' exp_name '\' exp_name '_Inputs.mat'], 'inputs');


end