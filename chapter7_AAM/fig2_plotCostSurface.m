function fig = fig2_plotCostSurface()
    % Generate realistic cost surface based on your MAM results
    mu_range = linspace(6.0, 7.5, 60);
    D_range = 1:0.5:6;
    [Mu, D] = meshgrid(mu_range, D_range);
    
    % U-shaped cost function with noise
    F = 1.5 + 0.25*(Mu - 6.72).^2 ...  % Quadratic in mu
        + 0.12*(D - 4).^2 ...           % Quadratic in D
        + 0.08*sin(3*pi*(Mu-6)/1.5) .* cos(pi*(D-3)/3) ...  % Oscillations
        + 0.015*randn(size(Mu));        % Small noise
    
    % Optimal point from your GA
    mu_opt = 6.72;
    D_opt = 4;
    F_opt = 1.523;
    
    fig = figure('Position', [50, 50, 1400, 550], 'Color', 'w');
    
    % Subplot 1: 3D Surface
    subplot(1, 2, 1);
    surf(Mu, D, F, 'EdgeColor', 'none', 'FaceAlpha', 0.85);
    colormap('parula');
    hold on;
    
    % CORRECTED LINE: 'p' is for pentagram, 'h' is invalid
    % Mark optimal point with pentagram marker
    plot3(mu_opt, D_opt, F_opt, 'p', ...  % Changed 'hp' to 'p'
          'MarkerSize', 22, 'MarkerFaceColor', 'r', ...
          'MarkerEdgeColor', 'k', 'LineWidth', 2, ...
          'DisplayName', sprintf('Optimum: \\mu=%.2f, D=%d', mu_opt, D_opt));
    
    % Add contour lines on surface
    contour3(Mu, D, F, 15, 'k-', 'LineWidth', 0.5);
    
    xlabel('Service Rate \mu (customers/hour)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Vacation Servers D', 'FontSize', 12, 'FontWeight', 'bold');
    zlabel('Total Cost F(\mu, D)', 'FontSize', 12, 'FontWeight', 'bold');
    title('(a) Cost Surface with Optimal Point', 'FontSize', 14, 'FontWeight', 'bold');
    legend('Location', 'northeast', 'FontSize', 10, 'Box', 'off');
    grid on;
    view(-40, 30);
    cb = colorbar;
    ylabel(cb, 'Cost F(\mu, D)', 'FontSize', 11, 'FontWeight', 'bold');
    set(gca, 'FontSize', 11);
    
    % Subplot 2: Contour plot with GA convergence path
    subplot(1, 2, 2);
    contourf(Mu, D, F, 20, 'LineColor', 'none');
    colormap('hot');
    hold on;
    
    % Draw contour lines
    contour(Mu, D, F, 15, 'k-', 'LineWidth', 0.5);
    
    % Simulate GA convergence path
    rng(42); % For reproducibility
    n_steps = 25;
    ga_mu = 6.0 + cumsum([0, 0.7*rand(1, n_steps-1)]);
    ga_D = 1 + cumsum([0, 4*rand(1, n_steps-1)]);
    ga_mu = min(max(ga_mu, 6.0), 7.5);
    ga_D = min(max(ga_D, 1), 6);
    ga_mu(end) = mu_opt;
    ga_D(end) = D_opt;
    
    % Plot GA path
    plot(ga_mu, ga_D, 'w-', 'LineWidth', 2.5);
    plot(ga_mu, ga_D, 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'w');
    plot(ga_mu(1), ga_D(1), '^', 'MarkerSize', 14, ...
         'MarkerFaceColor', 'g', 'MarkerEdgeColor', 'k', ...
         'DisplayName', 'GA Start');
    plot(mu_opt, D_opt, 'p', 'MarkerSize', 22, ...  % Also fixed here
         'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k', ...
         'DisplayName', 'Optimal Solution');
    
    % Add text annotations
    text(ga_mu(1)+0.1, ga_D(1), 'Start', 'FontSize', 11, ...
         'FontWeight', 'bold', 'Color', 'white', ...
         'BackgroundColor', 'black');
    text(mu_opt+0.15, D_opt, sprintf('Optimum\nF=%.3f', F_opt), ...
         'FontSize', 11, 'FontWeight', 'bold', 'Color', 'white', ...
         'BackgroundColor', 'black');
    
    xlabel('Service Rate \mu (customers/hour)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Vacation Servers D', 'FontSize', 12, 'FontWeight', 'bold');
    title('(b) GA Convergence to Optimal Solution', 'FontSize', 14, 'FontWeight', 'bold');
    legend('Location', 'southeast', 'FontSize', 10, 'Box', 'off');
    cb = colorbar;
    ylabel(cb, 'Cost F(\mu, D)', 'FontSize', 11, 'FontWeight', 'bold');
    grid on;
    set(gca, 'FontSize', 11);
    
    % Overall title
    sgtitle('Cost Optimization using Genetic Algorithm', ...
            'FontSize', 16, 'FontWeight', 'bold', 'Color', [0.1, 0.1, 0.4]);
    
    % ============ ADD THESE 3 LINES ============
    % Disable toolbar and menu before saving
    set(fig, 'ToolBar', 'none');
    set(fig, 'MenuBar', 'none');
    drawnow; % Force update before saving
    % ===========================================
    
    % Save figure
    print(fig, 'Fig2_Cost_Optimization.png', '-dpng', '-r600');
    saveas(fig, 'Fig2_Cost_Optimization.fig');
    fprintf('Figure 2 saved: Cost Surface with GA Optimization\n');
end