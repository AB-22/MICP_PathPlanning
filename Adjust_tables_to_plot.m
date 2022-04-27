function [num_of_steps,cpu_time_avg,err_cpu_time,num_of_vars_avg,err_num_of_vars,...
    num_of_iters_avg,err_num_of_iters]=Adjust_tables_to_plot(exp_names)


for i=1:size(exp_names,3)
    for j=1:size(exp_names,2)
        if  i~=3 || j<8
            for k=1:size(exp_names,1)
            
                load(exp_names(k,j,i));
                cpu_time(k)=outputs.Time;
                num_of_vars(k)=outputs.Num_of_variables;
                num_of_iters(k)=outputs.Num_of_iters;
        
            
            end
        
            num_of_steps(j,i)=outputs.path.number_of_steps;
            cpu_time_avg(j,i)=mean(cpu_time);
            num_of_vars_avg(j,i)=mean(num_of_vars);
            num_of_iters_avg(j,i)=mean(num_of_iters);
        
            err_cpu_time(j,i)=std(cpu_time)/sqrt(length(cpu_time));
            err_num_of_vars(j,i)=std(num_of_vars)/sqrt(length(num_of_vars));
            err_num_of_iters(j,i)=std(num_of_iters)/sqrt(length(num_of_iters));
        end
    end
end

num_of_steps(num_of_steps==0)=nan;
cpu_time_avg(cpu_time_avg==0)=nan;
num_of_vars_avg(num_of_vars_avg==0)=nan;
num_of_iters_avg(num_of_iters_avg==0)=nan;

err_cpu_time(err_cpu_time==0)=nan;
        
end