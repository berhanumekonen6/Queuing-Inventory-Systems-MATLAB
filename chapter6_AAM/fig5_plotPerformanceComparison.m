function fig = fig5_plotPerformanceComparison()
    % Three scenarios for comparison
    scenarios = {'Our Model (Full)', 'No AR Mechanisms', 'No Vacations'};
    
    % Performance metrics
    metrics = {'E_I', 'L_q', 'W_q', 'LR', 'P_B', 'F'};
    metric_names = {'Mean Inventory', 'Queue Length', 'Waiting Time', ...
                    'Customer Loss', 'Busy \%', 'Total Cost'};
    
    % Data based on your MAM results
    data = [
        6.03, 2.71e-9, 0.652, 27.25, 68.2, 1.523;   % Full model
        5.87, 4.52e-7, 0.891, 42.18, 71.5, 2.417;   % No AR
        6.15, 3.14e-8, 0.723, 31.42, 82.3, 1.842    % No vacation
    ];
    
    % Normalize for radar plot
    data_norm = zeros(size(data));
    for i = 1:size(data, 2)
        if i == 6 % Cost (lower is better)
            data_norm(:, i) = min(data(:, i)) ./ data(:, i);
        else % Other metrics (case-specific normalization)
            if i == 5 % Busy percentage (50-100% ideal)
                data_norm(:, i) = (100 - abs(data(:, i) - 75)) / 50;
            else
                data_norm(:, i) = data(:, i) / max(data(:, i));
            end
        end
    end
    
    fig = figure('Position', [50, 50, 1400, 600], 'Color', 'w');
    
    % Subplot 1: Radar plot
    subplot(1, 2, 1);
    angles = linspace(0, 2*pi, length(metrics)+1);
    angles = angles(1:end-1);
    angles = angles(:); % Make it a column vector
    
    % Plot each scenario
    colors = [0.2, 0.5, 0.8; 0.8, 0.3, 0.3; 0.3, 0.7, 0.4];
    
    for s = 1:3
        % Create closed polygon for radar plot
        values = data_norm(s, :);
        values_closed = [values, values(1)]; % Close the polygon
        angles_closed = [angles; angles(1)]; % Close the angles
        
        polarplot(angles_closed, values_closed, '-o', 'LineWidth', 2.5, ...
                  'Color', colors(s, :), 'MarkerSize', 8, ...
                  'MarkerFaceColor', colors(s, :));
        hold on;
    end
    
    % Customize polar plot
    ax = gca;
    ax.ThetaTick = rad2deg(angles);
    ax.ThetaTickLabel = metric_names;
    ax.RTick = [0.2, 0.4, 0.6, 0.8, 1.0];
    ax.RTickLabel = {'20%', '40%', '60%', '80%', '100%'};
    ax.FontSize = 10;
    ax.FontWeight = 'bold';
    title('(a) Performance Comparison (Normalized)', ...
          'FontSize', 14, 'FontWeight', 'bold', 'Position', [0, 1.15, 0]);
    legend(scenarios, 'Location', 'southoutside', 'Orientation', 'horizontal', ...
           'FontSize', 11, 'Box', 'off');
    
    % Subplot 2: Bar chart with actual values
    subplot(1, 2, 2);
    x = 1:length(metrics);
    width = 0.25;
    
    for s = 1:3
        offset = (s-2)*width;
        bars = bar(x + offset, data(s, :), width, ...
                   'FaceColor', colors(s, :), ...
                   'EdgeColor', 'k', 'LineWidth', 1);
        
        % Add value labels for significant metrics
        for m = 1:length(metrics)
            % Compare strings properly
            if strcmp(metrics{m}, 'F') || strcmp(metrics{m}, 'LR')
                if s == 1
                    text(x(m) + offset, data(s, m) + 0.1*max(data(:, m)), ...
                         sprintf('%.3f', data(s, m)), ...
                         'FontSize', 9, 'FontWeight', 'bold', ...
                         'HorizontalAlignment', 'center', ...
                         'BackgroundColor', 'white', ...
                         'VerticalAlignment', 'bottom');
                end
            end
        end
        hold on;
    end
    
    % Calculate percentage improvements
    improv_AR = 100*(data(2,6) - data(1,6))/data(2,6);  % Cost improvement with AR
    improv_vac = 100*(data(3,6) - data(1,6))/data(3,6); % Cost improvement with vacation
    
    % Annotate improvements
    text(5.5, max(data(:,6))*0.9, ...
         sprintf('AR saves: %.1f%%', improv_AR), ...
         'FontSize', 11, 'FontWeight', 'bold', ...
         'Color', colors(2, :), 'BackgroundColor', 'white', ...
         'EdgeColor', 'k');
    text(5.5, max(data(:,6))*0.8, ...
         sprintf('Vacation saves: %.1f%%', improv_vac), ...
         'FontSize', 11, 'FontWeight', 'bold', ...
         'Color', colors(3, :), 'BackgroundColor', 'white', ...
         'EdgeColor', 'k');
    
    set(gca, 'XTick', x, 'XTickLabel', metric_names);
    xlabel('Performance Metric', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Value', 'FontSize', 12, 'FontWeight', 'bold');
    title('(b) Actual Performance Values', 'FontSize', 14, 'FontWeight', 'bold');
    legend(scenarios, 'Location', 'northwest', 'FontSize', 11, 'Box', 'off');
    grid on;
    set(gca, 'FontSize', 11);
    
    % Overall title
    sgtitle('Performance Benefits of Integrated Features', ...
            'FontSize', 16, 'FontWeight', 'bold', 'Color', [0.1, 0.1, 0.4]);
    
    % ========== FIX FOR TOOLBAR WARNING ==========
    % Hide figure toolbar before saving
    set(fig, 'ToolBar', 'none');
    % =============================================
    
    % Save figure
    print(fig, 'Fig5_Performance_Comparison.png', '-dpng', '-r600');
    saveas(fig, 'Fig5_Performance_Comparison.fig');
    fprintf('Figure 5 saved: Performance Comparison\n');
end