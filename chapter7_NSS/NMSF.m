
% Neutrosophic Membership Functions for Lq, Ls, Wq

alpha = linspace(0, 1, 11);

% Sample data for Lq
lLq = [0.02143, 0.025, 0.028, 0.031, 0.034, 0.037, 0.040, 0.043, 0.046, 0.048, 0.04876];
uLq = [0.18356, 0.165, 0.148, 0.132, 0.117, 0.103, 0.090, 0.078, 0.067, 0.057, 0.09412];

% Sample data for Ls
lLs = [0.15988, 0.172, 0.185, 0.197, 0.209, 0.221, 0.233, 0.245, 0.257, 0.269, 0.22157];
uLs = [0.48342, 0.462, 0.441, 0.421, 0.401, 0.382, 0.364, 0.346, 0.329, 0.312, 0.34639];

% Sample data for Wq
lWq = [0.00753, 0.008, 0.0085, 0.009, 0.0092, 0.0093, 0.0094, 0.00945, 0.0095, 0.00955, 0.00932];
uWq = [0.02931, 0.027, 0.025, 0.023, 0.021, 0.019, 0.017, 0.015, 0.013, 0.011, 0.02345];

% Function to plot neutrosophic interval
function plot_neutrosophic(alpha, lower, upper, titleText, ylabelText, filename)
    figure;

   hold on;
    fill([alpha fliplr(alpha)], [lower fliplr(upper)], [0.5 0.8 1], 'EdgeColor', 'none', 'FaceAlpha', 0.5);
    plot(alpha, lower, 'b--', 'LineWidth', 1.5);
    plot(alpha, upper, 'r--', 'LineWidth', 1.5);
    xlabel('\alpha (certainty level)');
    ylabel(ylabelText);
    title(titleText);
    legend('Truth Interval', 'Lower Bound', 'Upper Bound', 'Location', 'Best');
    grid on;
    hold off;
    saveas(gcf, filename, 'pdf');
end

% Generate and save plots
plot_neutrosophic(alpha, lLq, uLq, 'Neutrosophic Membership Function for L_q', 'Expected Queue Length', 'Lq_graph.pdf');
plot_neutrosophic(alpha, lLs, uLs, 'Neutrosophic Membership Function for L_s', 'Expected Number in System', 'Ls_graph.pdf');
plot_neutrosophic(alpha, lWq, uWq, 'Neutrosophic Membership Function for W_q', 'Expected Waiting Time in Queue', 'Wq_graph.pdf');
