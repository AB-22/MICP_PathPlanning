function h = vis_Draw2(robot, r, varargin)
Parser = inputParser;
Parser.FunctionName = 'vis_Draw';
Parser.addOptional('NodeRadius', 0.014);
Parser.addOptional('CablesRadius', 0.001);
Parser.addOptional('RodsRadius', 0.004);
Parser.addOptional('FaceAlpha', 1);
Parser.addOptional('NodeFaceColor',        [1 0.2 1]);
Parser.addOptional('PassiveNodeFaceColor', [1 0.2 1]);
Parser.addOptional('ActiveRodFaceColor', [0 0.3 0]);
Parser.addOptional('CableFaceColor', [0 0.2 0]);
Parser.addOptional('RodFaceColor',   [0.3 0.2 1]);
Parser.addOptional('ToAddNodeNumbers',   false);
Parser.addOptional('text_delta_x', 0.02);
Parser.addOptional('text_delta_z', 0.02);
Parser.parse(varargin{:});

node_radius = Parser.Results.NodeRadius;
cables_radius = Parser.Results.CablesRadius;
rods_radius = Parser.Results.RodsRadius;

for i = 1:size(r, 2)
    switch i
        case num2cell(robot.active_nodes)
            C = Parser.Results.NodeFaceColor;
        otherwise
            C = Parser.Results.PassiveNodeFaceColor;
    end
            
    h.nodes(i) = vis_Sphere(r(:, i), node_radius, ...
        'FaceAlpha', Parser.Results.FaceAlpha, 'FaceColor', C); 
    hold on;
end

index = 0;
for i = 1:size(robot.Cables, 1)
for j = 1:size(robot.Cables, 2)
if (i < j) && (robot.Cables(i, j) == 1)
    index = index + 1;
    h.cables(index) = vis_Cylinder(r(:, i), r(:, j), cables_radius, ...
        'FaceColor', Parser.Results.CableFaceColor, 'FaceAlpha', Parser.Results.FaceAlpha);
end
end
end

index = 0;
for i = 1:size(robot.Rods, 1)
    switch i
        case num2cell(robot.active_nodes)
            C = Parser.Results.RodFaceColor;
        otherwise
            C = Parser.Results.ActiveRodFaceColor;
    end
for j = 1:size(robot.Rods, 2)
if (i < j) && (robot.Rods(i, j) == 1)
    index = index + 1;
    h.rods(index) = vis_Cylinder(r(:, i), r(:, j), rods_radius, ...
        'FaceColor', C, 'FaceAlpha', Parser.Results.FaceAlpha);
    
    
end
end
end

if Parser.Results.ToAddNodeNumbers
h.node_numbers = vis_node_numbers(robot, r, ...
    'text_delta_x', Parser.Results.text_delta_x, ...
    'text_delta_z', Parser.Results.text_delta_z);

end