function outputs=Generate_outputs(exp_name,inputs,number_of_regions,start,finish,...
    number_of_steps,weight_goal,bigM,configs,gap_val,exp_num)
% this function generates the solution of the problem and save the results

cvx_clear;
cvx_solver_settings( 'MIPGap', gap_val );

fn = fieldnames(inputs);
for k=1:numel(fn)
    if strcmp(char(fn{k}),'A1')
        A1=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'A2')
        A2=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'A3')
        A3=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'A4')
        A4=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'A5')
        A5=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'A6')
%         A6=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'A7')
%         A7=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'A8')
%         A8=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'A9')
%         A9=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'A10')
%         A10=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'A11')
%         A11=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'A12')
        A12=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'A23')
        A23=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'A34')
        A34=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'A45')
        A45=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'A56')
%         A56=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'A67')
%         A67=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'A78')
%         A78=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'A89')
%         A89=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'A910')
%         A910=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'A1011')
%         A1011=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'b1')
        b1=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'b2')
        b2=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'b3')
        b3=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'b4')
        b4=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'b5')
        b5=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'b6')
%         b6=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'b7')
%         b7=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'b8')
%         b8=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'b9')
%         b9=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'b10')
%         b10=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'b11')
        b11=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'b12')
        b12=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'b23')
        b23=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'b34')
        b34=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'b45')
        b45=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'b56')
%         b56=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'b67')
%         b67=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'b78')
%         b78=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'b89')
%         b89=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'b910')
%         b910=inputs.(fn{k});
%     elseif strcmp(char(fn{k}),'b1011')
%         b1011=inputs.(fn{k});
    elseif strcmp(char(fn{k}),'maze')
        maze=inputs.(fn{k});
    end
end

n=3; % 3D case


o1 = ones(size(b1));
o2 = ones(size(b2));
o3 = ones(size(b3));
o4 = ones(size(b4));
o5 = ones(size(b5));
% o6 = ones(size(b6));
% o7 = ones(size(b7));
% o8 = ones(size(b8));
% o9 = ones(size(b9));
% o10 = ones(size(b10));
% o11 = ones(size(b11));

% Building Reference Configurations
for k=1:size(configs,2)
 config_array(:,:,k)=configs(k).nodes_position;
end
num_of_configs=size(config_array, 3);
num_of_drone_vertices=length(config_array(:,:,1));

% Here we solve the following MILP problem:

% min ||x(1)-x_start||+||x(k)-x_goal||+w.sum_k(||x(i+1)-x(i)|| s.t.
% Ai*x(k)<=bi+M(1-c(i,k)) , i=1,...,number_of_regions ,
% k=1,...,number_of_steps
% Ai*(P(:,:,j)+shift(j))<=bi+M(1-g(i,j)) ,j=1,...,number_of_configs
% ||P(:,:,j)-P_ref(:,:,j)||<=0 + M(1-s(j))
%c , g, s are binary variables
% sum_i(c(i,k))=1 , sum_i(g(i,j))=1 , sum_j(s(j))=1


%%%%%%%%%%%%% CVX PROBLEM%%%%%%%%%%%%%%%%
cvx_begin
    
    variable x(n, number_of_steps) %x is the variable expressing Steps
    binary variable c(number_of_regions, number_of_steps) % binary variable, choosing region
    binary variable s(num_of_configs,    number_of_steps) % binary variable, choosing config
    
    cost=0;
    for i=1:(number_of_steps-1)
        cost=cost+dot(x(:,i)-x(:,i+1), x(:,i)-x(:,i+1));
    end
    
    cost=cost+norm(x(:,1)-start)*weight_goal;
    cost=cost+norm(x(:,number_of_steps)- finish)*weight_goal;
    minimize(cost)
    
    subject to
    
%%%%% This is solution to a point-like drone  %%%%   
%         for k=1:number_of_steps
%             A1*(x(:,k)) <= b1 + ones(size(b1)) * (1-c(1,k))*bigM;
%             A2*(x(:,k)) <= b2 + ones(size(b2)) * (1-c(2,k))*bigM;
%             A3*(x(:,k)) <= b3 + ones(size(b3)) * (1-c(3,k))*bigM;
%             c(1,k)+c(2,k)+c(3,k) == 1; %%%%(error fixed)
%         end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%% This is solution to a drone with a single configuration %%%%   
%         for k=1:number_of_steps
%             for j = 1:num_of_drone_vertices
%                 A1*(x(:,k) + config_array(:,j, 1)) <= b1 + ones(size(b1)) * (1-c(1,k))*bigM;
%                 A2*(x(:,k) + config_array(:,j, 1)) <= b2 + ones(size(b2)) * (1-c(2,k))*bigM;
%                 A3*(x(:,k) + config_array(:,j, 1)) <= b3 + ones(size(b3)) * (1-c(3,k))*bigM;
%             end
%         end
%         c(1,:)+c(2,:)+c(3,:) == ones(1, number_of_steps);  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        for k=1:number_of_steps
            for i = 1:num_of_configs
                for j = 1:num_of_drone_vertices
                    A1*(x(:,k) + config_array(:,j, i)) <= b1 + o1 * (1-c(1,k))*bigM + o1 * (1-s(i,k))*bigM;
                    A2*(x(:,k) + config_array(:,j, i)) <= b2 + o2 * (1-c(2,k))*bigM + o2 * (1-s(i,k))*bigM;
                    A3*(x(:,k) + config_array(:,j, i)) <= b3 + o3 * (1-c(3,k))*bigM + o3 * (1-s(i,k))*bigM;
                    A4*(x(:,k) + config_array(:,j, i)) <= b4 + o4 * (1-c(4,k))*bigM + o4 * (1-s(i,k))*bigM;
                    A5*(x(:,k) + config_array(:,j, i)) <= b5 + o5 * (1-c(5,k))*bigM + o5 * (1-s(i,k))*bigM;
%                     A6*(x(:,k) + config_array(:,j, i)) <= b6 + o6 * (1-c(6,k))*bigM + o6 * (1-s(i,k))*bigM;
%                     A7*(x(:,k) + config_array(:,j, i)) <= b7 + o7 * (1-c(7,k))*bigM + o7 * (1-s(i,k))*bigM;
%                     A8*(x(:,k) + config_array(:,j, i)) <= b8 + o8 * (1-c(8,k))*bigM + o8 * (1-s(i,k))*bigM;
%                     A9*(x(:,k) + config_array(:,j, i)) <= b9 + o9 * (1-c(9,k))*bigM + o9 * (1-s(i,k))*bigM;
%                     A10*(x(:,k) + config_array(:,j, i)) <= b10 + o10 * (1-c(10,k))*bigM + o10 * (1-s(i,k))*bigM;
%                     A11*(x(:,k) + config_array(:,j, i)) <= b11 + o11 * (1-c(11,k))*bigM + o11 * (1-s(i,k))*bigM;
                end
            end
        end
        
        sum_regions = zeros(1, number_of_steps);
        for i = 1:number_of_regions
            sum_regions = c(i, :) + sum_regions;
        end
        sum_regions == ones(1, number_of_steps);
        
%         c(1,:)+c(2,:)+c(3,:)+c(4,:)+c(5,:)==ones(1, number_of_steps);
        
%             +c(4,:)+c(5,:)+c(6,:)+...
%             +c(7,:)+c(8,:)+c(9,:)+c(10,:)+c(11,:)== ones(1, number_of_steps);
        
        sum_conf = zeros(1, number_of_steps);
        for i = 1:num_of_configs
            sum_conf = s(i, :) + sum_conf;
        end
        sum_conf == ones(1, number_of_steps);   
        
cvx_solver_settings( 'dumpfile', ['Folder_' exp_name '\' 'CVX_results_of_MILP.mat'] )
cvx_end 


problem_status=cvx_status;
% fid = fopen(['Number_of_variables_MILP_' exp_name '.txt']);
% C = textscan(fid, '%s');
% numofvar=str2double(C{1,1}{4,1});
% fclose('all');
cvx_results=load(['Folder_' exp_name '\' 'CVX_results_of_MILP.mat']);
% T_cell = {T1, T2, T3, T4, T5, T6, T7, T8, T9,T10,T11};
% outputs.T_cell=T_cell;
%outputs.cvx_results=cvx_results;
outputs.x=x;
outputs.s=s;

outputs.path.start=start;
outputs.path.finish=finish;
outputs.path.number_of_steps=number_of_steps;
outputs.path.maze=maze;

outputs.Drone.config_array=config_array;
outputs.Drone.num_of_configs=num_of_configs;
outputs.Drone.num_of_drone_vertices=num_of_drone_vertices;
outputs.problem_status=problem_status;
outputs.Time=cvx_results.res.runtime;
outputs.Num_of_variables=length(cvx_results.res.x);
outputs.Num_of_iters=cvx_results.res.itercount;
outputs.solver_text=cvx_results.output;
outputs.Actual_gap=cvx_results.res.mipgap;
outputs.Preset_gap=gap_val;
mkdir (['Folder_' exp_name '\' exp_name '_gapValue(' num2str(gap_val) ')']);
mkdir (['Folder_' exp_name '\' exp_name '_gapValue(' num2str(gap_val) ')\' 'number_of_steps(' num2str(number_of_steps) ')']);
save(['Folder_' exp_name '\' exp_name '_gapValue(' num2str(gap_val) ')\' 'number_of_steps(' num2str(number_of_steps) ')\iteration_' num2str(exp_num) '_Outputs.mat'], 'outputs');
% delete (['Number_of_variables_ElbowShaped_maze_' exp_name '.txt']) ;
end