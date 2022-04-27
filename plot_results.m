function plot_results(num_of_steps,cpu_time_avg,err_cpu_time,num_of_vars_avg,err_num_of_vars,...
    num_of_iters_avg,err_num_of_iters,gap_values)
% This function draws the results

figure('Color', 'w', 'Name', 'cpu time');

for i=1:length(gap_values)
% Draw error bars (cpu_time)

    x=num_of_steps(:,i);
    y=cpu_time_avg(:,i);

    
    if i==1
        plot(x,y,'ro-','DisplayName',['gap=' num2str(gap_values(i))])
    elseif i==2
        plot(x,y,'bo-','DisplayName',['gap=' num2str(gap_values(i))])
    else
        plot(x,y,'go-','DisplayName',['gap=' num2str(gap_values(i))])
    end
    hold on;
    errorbar(x,y,err_cpu_time(:,i),'LineStyle','none', 'Color', 'k','linewidth', 1.2,'DisplayName','Error')
    ax = gca;
    ax.GridAlpha = 0.6;
    ax.LineWidth = 0.5;
    ax.MinorGridLineStyle = '-';
    ax.MinorGridAlpha = 0.2;
    ax.FontName = 'Tibetan Machine Uni';
    ax.FontSize = 18;
    xlabel_handle = xlabel('$$\#steps$$');
    xlabel_handle.Interpreter = 'latex';
    ylabel_handle = ylabel('$$cpu time$$(s)');
    ylabel_handle.Interpreter = 'latex';
    grid on;
    grid minor;
    drawnow;
    %axis equal;
end
lgd = legend('show');
lgd.FontSize = 8;
lgd.Location='northwest';

% Plot number of variables
figure('Color', 'w', 'Name', 'Number of variables');
for i=1:length(gap_values)
    x=num_of_steps(:,i);
    y=num_of_vars_avg(:,i);
    % plot(x,y,'ro-')
    % hold on
    % errorbar(x,y,yneg,ypos,xneg,xpos,'LineStyle','none', 'Color', 'k','linewidth', 1.2)
    % title('Number of variables')
    % xlabel('$$\theta$$(degrees)', 'Interpreter', 'latex')
    % ylabel('$$number of variables$$', 'Interpreter', 'latex');



    if i==1
        plot(x,y,'ro-','DisplayName',['gap=' num2str(gap_values(i))])
    elseif i==2
        plot(x,y,'bo-','DisplayName',['gap=' num2str(gap_values(i))])
    else
        plot(x,y,'go-','DisplayName',['gap=' num2str(gap_values(i))])
    end
    hold on;
    errorbar(x,y,err_num_of_vars(:,i),'LineStyle','none', 'Color', 'k','linewidth', 1.2,'DisplayName','Error')
    ax = gca;
    ax.GridAlpha = 0.6;
    ax.LineWidth = 0.5;
    ax.MinorGridLineStyle = '-';
    ax.MinorGridAlpha = 0.2;
    ax.FontName = 'Tibetan Machine Uni';
    ax.FontSize = 18;
    xlabel_handle = xlabel('$$\#steps$$');
    xlabel_handle.Interpreter = 'latex';
    ylabel_handle = ylabel('$$\#variables$$');
    ylabel_handle.Interpreter = 'latex';
    grid on;
    grid minor;
    drawnow;
    %axis equal;
end
lgd = legend('show');
lgd.FontSize = 8;
lgd.Location='northwest';
% Plot Iterations
figure('Color', 'w', 'Name', 'Number of Iterations');
for i=1:length(gap_values)
    
    x=num_of_steps(:,i);
    y=num_of_iters_avg(:,i);
    % plot(x,y,'ro-')
    % hold on
    % errorbar(x,y,yneg,ypos,xneg,xpos,'LineStyle','none', 'Color', 'k','linewidth', 1.2)
    % title('Number of Iterations')
    % xlabel('$$\theta$$(degrees)', 'Interpreter', 'latex')
    % ylabel('$$number of Iterations$$', 'Interpreter', 'latex');

    if i==1
        plot(x,y,'ro-','DisplayName',['gap=' num2str(gap_values(i))])
    elseif i==2
        plot(x,y,'bo-','DisplayName',['gap=' num2str(gap_values(i))])
    else
        plot(x,y,'go-','DisplayName',['gap=' num2str(gap_values(i))])
    end
    hold on;
    errorbar(x,y,err_num_of_iters(:,i),'LineStyle','none', 'Color', 'k','linewidth', 1.2,'DisplayName','Error')
    ax = gca;
    ax.GridAlpha = 0.6;
    ax.LineWidth = 0.5;
    ax.MinorGridLineStyle = '-';
    ax.MinorGridAlpha = 0.2;
    ax.FontName = 'Tibetan Machine Uni';
    ax.FontSize = 18;
    xlabel_handle = xlabel('$$\#steps$$');
    xlabel_handle.Interpreter = 'latex';
    ylabel_handle = ylabel('$$\#Iterations$$');
    ylabel_handle.Interpreter = 'latex';
    grid on;
    grid minor;
    drawnow;

    % %axis equal;
end
lgd = legend('show');
lgd.FontSize = 8;
lgd.Location='northwest';
end