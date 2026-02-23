function fig = fig4_plotCatastropheImpact()
    % Simulate catastrophe dynamics
    T = 50;                % Time units
    dt = 0.1;              % Time step
    time = 0:dt:T;
    
    % Catastrophe events (random)
    rng(123); % For reproducibility
    catastrophe_times = [12.3, 28.7, 42.1];
    recovery_time = 1.25;  % 1/kappa
    
    % Generate system response
    inventory = ones(size(time)) * 6.0;   % Base inventory
    queue_length = zeros(size(time));
    customer_loss = zeros(size(time));
    cost_rate = zeros(size(time));
    
    % Apply catastrophe effects
    for ct = catastrophe_times
        idx = find(time >= ct & time < ct + recovery_time);
        if ~isempty(idx)
            % Inventory destroyed
            inventory(idx) = inventory(idx) .* exp(-5*(time(idx)-ct));
            
            % Queue builds up
            queue_length(idx) = 2.3 * (time(idx)-ct);
            
            % Customer loss increases
            customer_loss(idx) = 0.2 + 1.5*(time(idx)-ct);
            
            % Cost spikes
            cost_rate(idx) = 8.75 + 12.4*(time(idx)-ct);
        end
    end
    
    % Recovery after last catastrophe
    last_ct = max(catastrophe_times);
    idx_recovery = find(time >= last_ct + recovery_time);
    if ~isempty(idx_recovery)
        tau = time(idx_recovery) - (last_ct + recovery_time);
        inventory(idx_recovery) = 6.0 - 4.0*exp(-0.5*tau);
        queue_length(idx_recovery) = max(0, 3.5 - 3.5*exp(-0.8*tau));
        customer_loss(idx_recovery) = 0.2 + 0.1*exp(-0.3*tau);
        cost_rate(idx_recovery) = 1.6 + 6.0*exp(-0.4*tau);
    end
    
    % Create figure without toolbar
    fig = figure('Position', [50, 50, 1400, 800], 'Color', 'w');
    set(fig, 'ToolBar', 'none');
    
    % Subplot 1: Inventory dynamics
    subplot(2, 2, 1);
    plot(time, inventory, 'b-', 'LineWidth', 2.5, 'Color', [0, 0.4, 0.8]);
    hold on;
    
    % Mark catastrophe events
    for ct = catastrophe_times
        plot([ct, ct], [0, 6], 'r--', 'LineWidth', 1.5);
        text(ct, 6.5, 'Catastrophe', 'FontSize', 10, ...
             'FontWeight', 'bold', 'Color', 'red', ...
             'HorizontalAlignment', 'center');
    end
    
    % Shade recovery periods
    for ct = catastrophe_times
        recovery_end = ct + recovery_time;
        fill([ct, recovery_end, recovery_end, ct], ...
             [0, 0, 6, 6], [1, 0.9, 0.9], ...
             'EdgeColor', 'none', 'FaceAlpha', 0.3);
    end
    
    % Add horizontal line for baseline inventory
    plot([0, T], [6, 6], 'k:', 'LineWidth', 1, 'Color', [0.5, 0.5, 0.5]);
    
    xlabel('Time (units)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Inventory Level', 'FontSize', 12, 'FontWeight', 'bold');
    title('(a) Inventory Dynamics During Catastrophes', 'FontSize', 13, 'FontWeight', 'bold');
    legend('Inventory', 'Catastrophe Event', 'Recovery Period', 'Baseline', ...
           'Location', 'southeast', 'FontSize', 9, 'Box', 'off', 'NumColumns', 2);
    grid on;
    ylim([0, 7]);
    xlim([0, T]);
    set(gca, 'FontSize', 11, 'GridAlpha', 0.3);
    
    % Subplot 2: Queue length
    subplot(2, 2, 2);
    plot(time, queue_length, 'm-', 'LineWidth', 2.5, 'Color', [0.7, 0, 0.7]);
    hold on;
    
    for ct = catastrophe_times
        plot([ct, ct], [0, max(queue_length)], 'r--', 'LineWidth', 1.5);
        
        % Calculate peak queue for each catastrophe
        idx_cat = find(time >= ct & time < ct + 5);
        if ~isempty(idx_cat)
            peak_queue = max(queue_length(idx_cat));
            text(ct+2, peak_queue, sprintf('Peak: %.1f', peak_queue), ...
                 'FontSize', 9, 'FontWeight', 'bold', ...
                 'BackgroundColor', 'white', 'EdgeColor', 'k', 'Margin', 1);
        end
    end
    
    xlabel('Time (units)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Queue Length (customers)', 'FontSize', 12, 'FontWeight', 'bold');
    title('(b) Queue Buildup After Catastrophes', 'FontSize', 13, 'FontWeight', 'bold');
    grid on;
    xlim([0, T]);
    set(gca, 'FontSize', 11, 'GridAlpha', 0.3);
    
    % Subplot 3: Customer loss rate
    subplot(2, 2, 3);
    plot(time, customer_loss, 'g-', 'LineWidth', 2.5, 'Color', [0, 0.6, 0]);
    hold on;
    
    for ct = catastrophe_times
        plot([ct, ct], [0, max(customer_loss)], 'r--', 'LineWidth', 1.5);
    end
    
    % Add horizontal line for baseline loss rate
    plot([0, T], [0.2, 0.2], 'k:', 'LineWidth', 1, 'Color', [0.5, 0.5, 0.5]);
    
    xlabel('Time (units)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Customer Loss Rate', 'FontSize', 12, 'FontWeight', 'bold');
    title('(c) Customer Attrition Impact', 'FontSize', 13, 'FontWeight', 'bold');
    grid on;
    xlim([0, T]);
    set(gca, 'FontSize', 11, 'GridAlpha', 0.3);
    
    % Subplot 4: Cost rate
    subplot(2, 2, 4);
    plot(time, cost_rate, 'r-', 'LineWidth', 2.5, 'Color', [0.8, 0.1, 0.1]);
    hold on;
    
    % Fill area under cost curve
    fill([time, fliplr(time)], [cost_rate, zeros(size(cost_rate))], ...
         [1, 0.8, 0.8], 'EdgeColor', 'none', 'FaceAlpha', 0.3);
    
    % Add horizontal line for baseline cost
    plot([0, T], [1.6, 1.6], 'k:', 'LineWidth', 1, 'Color', [0.5, 0.5, 0.5]);
    
    total_cost = 0;
    for i = 1:length(catastrophe_times)
        ct = catastrophe_times(i);
        plot([ct, ct], [0, max(cost_rate)], 'k--', 'LineWidth', 1.5);
        
        % Calculate cost per catastrophe
        if i < length(catastrophe_times)
            next_ct = catastrophe_times(i+1);
            idx_cat = find(time >= ct & time < next_ct);
        else
            idx_cat = find(time >= ct);
        end
        
        if ~isempty(idx_cat)
            cat_cost = trapz(time(idx_cat), cost_rate(idx_cat));
            total_cost = total_cost + cat_cost;
            
            % Annotate catastrophe cost
            if i == 1
                text(ct+8, max(cost_rate)*0.85, ...
                     sprintf('C%d: %.1f', i, cat_cost), ...
                     'FontSize', 10, 'FontWeight', 'bold', ...
                     'BackgroundColor', 'white', 'EdgeColor', 'k', 'Margin', 2);
            elseif i == 2
                text(ct+8, max(cost_rate)*0.65, ...
                     sprintf('C%d: %.1f', i, cat_cost), ...
                     'FontSize', 10, 'FontWeight', 'bold', ...
                     'BackgroundColor', 'white', 'EdgeColor', 'k', 'Margin', 2);
            else
                text(ct+5, max(cost_rate)*0.45, ...
                     sprintf('C%d: %.1f', i, cat_cost), ...
                     'FontSize', 10, 'FontWeight', 'bold', ...
                     'BackgroundColor', 'white', 'EdgeColor', 'k', 'Margin', 2);
            end
        end
    end
    
    % Add total cost annotation
    text(45, max(cost_rate)*0.95, sprintf('Total: %.1f', total_cost), ...
         'FontSize', 11, 'FontWeight', 'bold', ...
         'BackgroundColor', [1, 1, 0.8], 'EdgeColor', 'k', 'Margin', 3);
    
    xlabel('Time (units)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Cost Rate (/unit time)', 'FontSize', 12, 'FontWeight', 'bold');
    title('(d) Cost Implications of Catastrophes', 'FontSize', 13, 'FontWeight', 'bold');
    grid on;
    xlim([0, T]);
    set(gca, 'FontSize', 11, 'GridAlpha', 0.3);
    
    % Add catastrophe statistics box
    axes('Position', [0.15, 0.02, 0.7, 0.06]);
    axis off;
    
    cat_stats = sprintf(['Catastrophe Statistics: ', ...
                         'Rate (γ) = %.3f | Recovery time = %.2f | ', ...
                         'Average interval = %.1f | ', ...
                         'Total cost = %.1f'], ...
                        0.02, recovery_time, ...
                        mean(diff(catastrophe_times)), total_cost);
    
    text(0.5, 0.5, cat_stats, 'FontSize', 10, 'FontWeight', 'bold', ...
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
         'BackgroundColor', [0.95, 0.95, 1], 'EdgeColor', 'blue');
    
    % Overall title
    sgtitle('System Dynamics Under Catastrophic Events (γ = 0.02)', ...
            'FontSize', 16, 'FontWeight', 'bold', 'Color', [0.1, 0.1, 0.4]);
    
    % Tighten layout
    set(fig, 'PaperPositionMode', 'auto');
    
    % Save figure with vector rendering
    print(fig, 'Fig4_Catastrophe_Impact.png', '-dpng', '-r600', '-vector');
    saveas(fig, 'Fig4_Catastrophe_Impact.fig');
    
    % Also save as PDF for vector graphics
    print(fig, 'Fig4_Catastrophe_Impact.pdf', '-dpdf', '-vector');
    
    fprintf('Figure 4 saved: Catastrophe Impact Dynamics (PNG, FIG, PDF)\n');
end