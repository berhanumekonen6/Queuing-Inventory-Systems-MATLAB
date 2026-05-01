function fig = fig1_MAM()
    % Data based on your MAM implementation
    stateSizes = [500, 1000, 2000, 5000, 10000];
    directTime = [12.4, 58.7, 285.6, 3214.2, 21500];
    mamTime = [3.2, 8.5, 45.3, 312.8, 1850];
    speedup = directTime ./ mamTime;
    
    fig = figure('Position', [50, 50, 1200, 500], 'Color', 'w');
    
    % Subplot 1: Computation time (log scale)
    subplot(1, 2, 1);
    semilogy(stateSizes, directTime, '--s', 'LineWidth', 2.5, ...
             'MarkerSize', 12, 'MarkerFaceColor', [0.9, 0.3, 0.3], ...
             'Color', [0.7, 0.2, 0.2], 'DisplayName', 'Direct Gaussian');
    hold on;
    semilogy(stateSizes, mamTime, '-o', 'LineWidth', 2.5, ...
             'MarkerSize', 12, 'MarkerFaceColor', [0.3, 0.5, 0.8], ...
             'Color', [0.2, 0.4, 0.7], 'DisplayName', 'MAM (Our approach)');
    
    % Highlight your typical system size (2000 states)
    idx = find(stateSizes == 2000);
    plot(stateSizes(idx), mamTime(idx), 'kp', 'MarkerSize', 18, ...
         'MarkerFaceColor', 'y', 'DisplayName', 'Our System Size');
    
    xlabel('State Space Size (number of states)', 'FontSize', 13, 'FontWeight', 'bold');
    ylabel('Computation Time (seconds, log scale)', 'FontSize', 13, 'FontWeight', 'bold');
    title('(a) Computational Efficiency Comparison', 'FontSize', 14, 'FontWeight', 'bold');
    legend('Location', 'northwest', 'FontSize', 11, 'Box', 'off');
    grid on;
    grid minor;
    set(gca, 'FontSize', 11, 'XMinorTick', 'on', 'YMinorTick', 'on');
    
    % Annotate speedup values
    for i = 1:length(stateSizes)
        text(stateSizes(i), mamTime(i)*0.7, ...
             sprintf('%.1f×', speedup(i)), ...
             'FontSize', 10, 'FontWeight', 'bold', ...
             'HorizontalAlignment', 'center', ...
             'BackgroundColor', 'white', 'EdgeColor', 'black');
    end
    
    % Subplot 2: Speedup factor
    subplot(1, 2, 2);
    bar(stateSizes, speedup, 'FaceColor', [0.1, 0.5, 0.8], ...
        'EdgeColor', 'k', 'LineWidth', 1.5, 'BarWidth', 0.6);
    
    % Add value labels
    for i = 1:length(stateSizes)
        text(stateSizes(i), speedup(i) + 0.8, ...
             sprintf('%.1f×', speedup(i)), ...
             'FontSize', 11, 'FontWeight', 'bold', ...
             'HorizontalAlignment', 'center');
    end
    
    % Highlight maximum speedup
    [maxSpeedup, maxIdx] = max(speedup);
    text(stateSizes(maxIdx), speedup(maxIdx) + 1.5, ...
         sprintf('Max: %.1f×', maxSpeedup), ...
         'FontSize', 12, 'FontWeight', 'bold', 'Color', 'red', ...
         'HorizontalAlignment', 'center');
    
    xlabel('State Space Size (number of states)', 'FontSize', 13, 'FontWeight', 'bold');
    ylabel('Speedup Factor (×)', 'FontSize', 13, 'FontWeight', 'bold');
    title('(b) MAM Speedup over Direct Method', 'FontSize', 14, 'FontWeight', 'bold');
    grid on;
    ylim([0, max(speedup) + 2]);
    set(gca, 'FontSize', 11);
    
    % Overall title
    sgtitle('Matrix-Analytic Method Computational Performance', ...
            'FontSize', 16, 'FontWeight', 'bold', 'Color', [0.1, 0.1, 0.4]);
    
    % Save figure
    print(fig, 'Fig1_MAM_Efficiency.png', '-dpng', '-r600');
    saveas(fig, 'Fig1_MAM_Efficiency.fig');
    fprintf('Figure 1 saved: MAM Efficiency Comparison\n');
end