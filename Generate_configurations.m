function configs=Generate_configurations(n,num_of_configs, num_of_drone_vertices ,config_name)
% Building Reference Configurations (Rectanglular configuration for the
% drone) with n-dimensions
configs = zeros(n, num_of_drone_vertices, num_of_configs);
min_squash = 0.02; max_squash = 0.2;

% for i = 1:num_of_configs
%     scale=-5 + (5+5)*rand;
%     mu_x = min_squash * (num_of_configs - (i - 1))/num_of_configs + max_squash * (i - 1)/num_of_configs;
%     mu_z = max_squash * (num_of_configs - (i - 1))/num_of_configs + min_squash * (i - 1)/num_of_configs;
%     config_array(:,:, i)=scale*diag([mu_x, 1, mu_z])*get_cube([0;0;0], 1);
% end

for i = 1:num_of_configs
    alpha = (i - 1) / num_of_configs;
    mu_x = min_squash * alpha + max_squash * (1 - alpha);
    mu_z = max_squash * alpha + min_squash * (1 - alpha);
    mu_y = (max_squash + min_squash) / 2;
    
    configs(:,:, i)= diag([mu_x, mu_y, mu_z]) * get_cube([0;0;0], 1);
end


save(['Configs_Folder\' config_name '.mat'], 'configs');


end