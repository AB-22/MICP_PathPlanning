function draw_maze(vis)
vis_Body(vis.maze.V1, 'FaceAlpha', 0.2, 'EdgeAlpha', 0.01, 'FaceColor', [1 0.8 0.2]); hold on;
vis_Body(vis.maze.V2, 'FaceAlpha', 0.2, 'EdgeAlpha', 0.01, 'FaceColor', [0.8 1 0.2]); 
vis_Body(vis.maze.V3, 'FaceAlpha', 0.2, 'EdgeAlpha', 0.01, 'FaceColor', [0.4 1 0.6]); 
end