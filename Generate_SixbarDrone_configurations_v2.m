function configs=Generate_SixbarDrone_configurations_v2(n,num_of_configs,config_name)
% Building Reference Configurations (Rectanglular configuration for the
% drone) with n-dimensions

Cables = zeros(12, 12);
Cables(1, 5) = 1;
Cables(1, 6) = 1;
Cables(1, 9) = 1;
Cables(1, 11) = 1;

Cables(2, 7) = 1;
Cables(2, 8) = 1;
Cables(2, 9) = 1;
Cables(2, 11) = 1;

Cables(3, 5) = 1;
Cables(3, 6) = 1;
Cables(3, 10) = 1;
Cables(3, 12) = 1;

Cables(4, 7) = 1;
Cables(4, 8) = 1;
Cables(4, 10) = 1;
Cables(4, 12) = 1;

Cables(5, 1) = 1;
Cables(5, 3) = 1;
Cables(5, 9) = 1;
Cables(5, 10) = 1;

Cables(6, 1) = 1;
Cables(6, 3) = 1;
Cables(6, 11) = 1;
Cables(6, 12) = 1;

Cables(7, 2) = 1;
Cables(7, 4) = 1;
Cables(7, 9) = 1;
Cables(7, 10) = 1;

Cables(8, 2) = 1;
Cables(8, 4) = 1;
Cables(8, 11) = 1;
Cables(8, 12) = 1;

Cables(9, 1) = 1;
Cables(9, 2) = 1;
Cables(9, 5) = 1;
Cables(9, 7) = 1;

Cables(10, 3) = 1;
Cables(10, 4) = 1;
Cables(10, 5) = 1;
Cables(10, 7) = 1;

Cables(11, 1) = 1;
Cables(11, 2) = 1;
Cables(11, 6) = 1;
Cables(11, 8) = 1;

Cables(12, 3) = 1;
Cables(12, 4) = 1;
Cables(12, 6) = 1;
Cables(12, 8) = 1;

% if max(Cables(:)) > 1
%     error('There is sth wrong!')
% end


Rods = zeros(12, 12);
Rods(1, 2) = 1;
Rods(2, 1) = 1;

Rods(3, 4) = 1;
Rods(4, 3) = 1;

Rods(5, 6) = 1;
Rods(6, 5) = 1;

Rods(7, 8) = 1;
Rods(8, 7) = 1;

Rods(9, 10) = 1;
Rods(10, 9) = 1;

Rods(11, 12) = 1;
Rods(12, 11) = 1;

num_of_drone_vertices=12; % Icosahedron
%configs = zeros(n, num_of_drone_vertices, num_of_configs);
min_squash = 0.3; max_squash =1 ;

for i = 1:num_of_configs
    alpha = (i - 1) / num_of_configs;
    mu_x = min_squash * alpha + max_squash * (1 - alpha);
    mu_z = max_squash * alpha + min_squash * (1 - alpha);
    mu_y = (max_squash + min_squash) / 2;
    
    configs(i).number_of_nodes=12;
    configs(i).Cables=Cables;
    configs(i).Rods=Rods;
    configs(i).Connectivity = Cables + Rods;

    L_cables = Cables * 0.3; % Measured from real design
    L_rods = Rods * 0.5;     % Measured from real design
    configs(i).rest_lengths = L_cables + L_rods;

    mu_cables = Cables * 10; % Supposed
    mu_rods = Rods * 100;    % Supposed
    configs(i).stiffness_coef = mu_cables + mu_rods;

    configs(i).nodes_masses=ones(12,1); % Supposed
    configs(i).nodes_position=diag([mu_x, mu_y, mu_z]) * get_icosahedron();
    %configs(i).active_nodes=[1,2,3,4,5,6,7,8,9,10,11,12];
    configs(i).active_nodes=[5,6,7,8,9,10,11,12];
    
    f_array = get_elastic_force_sums_nodes_wrapper1(configs(i))
%     deformable_rod1_length=norm(configs(i).nodes_position(:,1)-configs(i).nodes_position(:,2));
%     deformable_rod2_length=norm(configs(i).nodes_position(:,3)-configs(i).nodes_position(:,4));
    
    get_potential_energy_fnc_header = ...
        get_potential_energy_fmincon_wrapper(configs(i).Connectivity, configs(i).nodes_position, ...
                                         configs(i).stiffness_coef, configs(i).rest_lengths, configs(i).active_nodes); % active nodes indices
    x = fminunc(get_potential_energy_fnc_header, configs(i).nodes_position(:, configs(i).active_nodes));

    nodes_position = configs(i).nodes_position;
    nodes_position(:, configs(i).active_nodes) = x;
    configs(i).nodes_position(:,configs(i).active_nodes)=x;

    f_array = get_elastic_force_sums_nodes(configs(i).Connectivity, nodes_position, ...
                                         configs(i).stiffness_coef, configs(i).rest_lengths)
                                     
    Sum_of_all_elastic_forces=sum(f_array,2);

    if round(Sum_of_all_elastic_forces,4)~=zeros(3,1)
        error('Not a good configuration!')
    end

end


save(['Configs_Folder\' config_name '.mat'], 'configs');


end