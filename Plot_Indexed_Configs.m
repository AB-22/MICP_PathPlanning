function Plot_Indexed_Configs(s)
config_ids=[1;2;3;4;5;6;7;8];
p=s'*config_ids;
figure('Color', 'w', 'Name', 'Configuration Indexes')
stem(p)
hold on;
ax = gca;
ax.GridAlpha = 0.6;
ax.LineWidth = 0.01;
ax.MinorGridLineStyle = '-';
ax.MinorGridAlpha = 0;
ax.FontName = 'Tibetan Machine Uni';
ax.FontSize = 18;
xlabel_handle = xlabel('$$\#steps$$');
xlabel_handle.Interpreter = 'latex';
ylabel_handle = ylabel('$$Configuration$$');
ylabel_handle.Interpreter = 'latex'

grid on;
grid minor;
drawnow;
axis equal

end