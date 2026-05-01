function fig = fig3_plotSensitivityAnalysis()
    % Parameter sensitivity data based on your MAM results
    params = {'\gamma', 'r', '\alpha', '\beta', '\mu', 'D'};
    param_names = {'Catastrophe Rate', 'Retention', 'Reneging Rate', ...
                   'Attraction', 'Service Rate', 'Vacation Duration'};
    base_values = [0.02, 0.4, 0.029, 0.3, 6.72, 4];
    sensitivities = [0.85, 0.62, 0.28, 0.22, 0.19, 0.16];
    cost_impacts = [+186, -72, +25, +31, -21, -18]; % percentage
    
    % Colors for different parameters
    colors = [
        0.9, 0.2, 0.2;    % Red for catastrophe
        0.2, 0.7, 0.3;    % Green for retention
        0.2, 0.4, 0.8;    % Blue for reneging
        0.9, 0.6, 0.1;    % Orange for attraction
        0.6, 0.2, 0.7;    % Purple for service rate
        0.3, 0.7, 0.8     % Cyan for vacation
    ];
    
    % Create figure without toolbar to avoid warning
    fig = figure('Position', [50, 50, 1400, 600], 'Color', 'w');
    set(fig, 'ToolBar', 'none');
    
    % Subplot 1: Sensitivity indices (Tornado plot)
    subplot(2, 3, 1);
    [sorted_sens, idx] = sort(sensitivities, 'descend');
    sorted_params = params(idx);
    sorted_colors = colors(idx, :);
    
    bh = barh(sorted_sens, 'FaceColor', 'flat');
    for i = 1:length(sorted_sens)
        bh.CData(i, :) = sorted_colors(i, :);
        text(sorted_sens(i) + 0.02, i, ...
             sprintf('%.2f', sorted_sens(i)), ...
             'FontSize', 10, 'FontWeight', 'bold', ...
             'VerticalAlignment', 'middle');
    end
    
    set(gca, 'YTick', 1:length(sorted_params), ...
             'YTickLabel', sorted_params, ...
             'YDir', 'reverse');
    xlabel('Sensitivity Index', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Parameter', 'FontSize', 12, 'FontWeight', 'bold');
    title('(a) Parameter Sensitivity Ranking', 'FontSize', 13, 'FontWeight', 'bold');
    grid on;
    xlim([0, max(sorted_sens) * 1.2]);
    set(gca, 'FontSize', 11, 'Color', [0.98, 0.98, 0.98]);
    
    % Subplot 2: Cost impact percentage
    subplot(2, 3, 2);
    cost_impacts_sorted = cost_impacts(idx);
    
    bh2 = barh(cost_impacts_sorted, 'FaceColor', 'flat');
    for i = 1:length(cost_impacts_sorted)
        bh2.CData(i, :) = sorted_colors(i, :);
        if cost_impacts_sorted(i) > 0
            text(cost_impacts_sorted(i) + 5, i, ...
                 sprintf('+%.0f%%', cost_impacts_sorted(i)), ...
                 'FontSize', 10, 'FontWeight', 'bold', ...
                 'VerticalAlignment', 'middle');
        else
            text(cost_impacts_sorted(i) - 8, i, ...
                 sprintf('%.0f%%', cost_impacts_sorted(i)), ...
                 'FontSize', 10, 'FontWeight', 'bold', ...
                 'VerticalAlignment', 'middle');
        end
    end
    
    set(gca, 'YTick', 1:length(sorted_params), ...
             'YTickLabel', sorted_params, ...
             'YDir', 'reverse');
    xlabel('Cost Impact (%)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Parameter', 'FontSize', 12, 'FontWeight', 'bold');
    title('(b) Total Cost Impact', 'FontSize', 13, 'FontWeight', 'bold');
    grid on;
    set(gca, 'FontSize', 11, 'Color', [0.98, 0.98, 0.98]);
    
    % Subplots 3-6: Individual parameter sweeps
    param_ranges = {
        linspace(0.01, 0.05, 20);      % gamma
        linspace(0.2, 0.8, 20);        % r
        linspace(0.01, 0.05, 20);      % alpha
        linspace(0.1, 0.6, 20);        % beta
        linspace(6.0, 7.5, 20);        % mu
        linspace(1, 6, 6)              % D
    };
    
    cost_functions = {
        @(x) 1.5 + 80*x.^1.5;          % gamma cost
        @(x) 2.0 - 1.2*x;              % r cost
        @(x) 1.6 + 15*(x - 0.02).^2;   % alpha cost
        @(x) 1.55 + 0.8*x;             % beta cost
        @(x) 1.5 + 0.25*(x - 6.72).^2; % mu cost
        @(x) 1.5 + 0.12*(x - 4).^2     % D cost
    };
    
    positions = [3, 4, 5, 6];
    titles = {'(c) Catastrophe Rate \gamma', '(d) Retention r', ...
              '(e) Reneging Rate \alpha', '(f) Attraction \beta'};
    
    for i = 1:4
        subplot(2, 3, positions(i));
        
        x = param_ranges{i};
        y = cost_functions{i}(x);
        
        plot(x, y, '-', 'LineWidth', 2.5, 'Color', colors(i, :));
        hold on;
        
        % Mark base value
        base = base_values(i);
        base_cost = cost_functions{i}(base);
        plot(base, base_cost, 'ko', 'MarkerSize', 10, ...
             'MarkerFaceColor', 'k');
        
        % Add text annotation
        text(base, base_cost*1.05, ...
             sprintf('Base: %.3f\nCost: %.3f', base, base_cost), ...
             'FontSize', 9, 'FontWeight', 'bold', ...
             'HorizontalAlignment', 'center', ...
             'BackgroundColor', 'white', ...
             'EdgeColor', 'k', 'Margin', 2);
        
        xlabel(params{i}, 'FontSize', 11, 'FontWeight', 'bold');
        ylabel('Total Cost F', 'FontSize', 11, 'FontWeight', 'bold');
        title(titles{i}, 'FontSize', 12, 'FontWeight', 'bold');
        grid on;
        set(gca, 'FontSize', 10, 'Color', [0.98, 0.98, 0.98]);
        
        % Add minor grid
        grid minor;
    end
    
    % Add color legend
    subplot(2, 3, 5); % Reuse one of the subplot positions for legend
    cla; % Clear axes
    axis off;
    
    % Create custom legend
    legend_text = cell(1, 6);
    for i = 1:6
        legend_text{i} = sprintf('%s: %s', params{i}, param_names{i});
    end
    
    % Create invisible axes for legend
    axes('Position', [0.68, 0.15, 0.25, 0.15]);
    hold on;
    for i = 1:6
        plot(NaN, NaN, 's', 'MarkerSize', 10, 'MarkerFaceColor', colors(i, :), ...
             'MarkerEdgeColor', colors(i, :));
    end
    legend(legend_text, 'Location', 'northwest', 'FontSize', 9, ...
           'Box', 'off', 'NumColumns', 2);
    axis off;
    
    % Overall title
    sgtitle('Sensitivity Analysis: Parameter Impact on System Performance', ...
            'FontSize', 16, 'FontWeight', 'bold', 'Color', [0.1, 0.1, 0.4]);
    
    % Tighten layout
    set(fig, 'PaperPositionMode', 'auto');
    
    % Save figure with vector rendering
    print(fig, 'Fig3_Sensitivity_Analysis.png', '-dpng', '-r600', '-vector');
    saveas(fig, 'Fig3_Sensitivity_Analysis.fig');
    
    % Also save as PDF for vector graphics
    print(fig, 'Fig3_Sensitivity_Analysis.pdf', '-dpdf', '-vector');
    
    fprintf('Figure 3 saved: Sensitivity Analysis (PNG, FIG, PDF)\n');
end