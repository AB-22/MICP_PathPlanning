clear all;
close all;
clc

steps_values=[3 5 7 10 12 15 18 20 25 27];
gap_values=[0.05 0.02 0.005];
num_of_exps=10;

exp_name='data_maze_3Rooms_2Corridors_6bars_Final'; % Experiment name





for i=1:length(gap_values)
    gap_val=gap_values(i);
    exp_title=['Folder_' exp_name '\' exp_name '_gapValue(' num2str(gap_val) ')\'];
    for j=1:length(steps_values)
        number_of_steps=steps_values(j); % number of the steps taken by the drone from start to finish point
            
        exp_order=['number_of_steps(' num2str(number_of_steps)];
        
         for k=1:num_of_exps
                exp_num=k;
                if number_of_steps<=18 || gap_val~=0.005
                    exp_names(k,j,i)=convertCharsToStrings([exp_title exp_order ')\iteration_' num2str(exp_num) '_Outputs.mat']);
                else
                    exp_names(k,j,i)="";

                end
                      
         end
            
        
                
    end
end

[num_of_steps,cpu_time_avg,err_cpu_time,num_of_vars_avg,err_num_of_vars,...
    num_of_iters_avg,err_num_of_iters]=Adjust_tables_to_plot(exp_names);


plot_results(num_of_steps,cpu_time_avg,err_cpu_time,num_of_vars_avg,err_num_of_vars,...
    num_of_iters_avg,err_num_of_iters,gap_values)


