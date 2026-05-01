clc; clear; close all;

%% === Define SVTNN Parameters ===
% SVTNN for arrival rate λ: T, I, F components
SVTNN.lambda = struct( ...
    'T', [10, 11, 11.5, 12], ...
    'I', [0.2, 0.3, 0.4, 0.5], ...
    'F', [0.1, 0.15, 0.2, 0.25]);

% SVTNN for service rate μ: T, I, F components
SVTNN.mu = struct( ...
    'T', [6.5, 7, 7.5, 8], ...
    'I', [0.5, 0.6, 0.7, 0.8], ...
    'F', [0.3, 0.4, 0.5, 0.6]);

%% === Define Cut Levels ===
alpha = 0.8; beta = 0.1; gamma = 0.1;

% Convert SVTNNs to crisp intervals via (α, β, γ)-cut
lambda_int = cutSVTNN(SVTNN.lambda, alpha, beta, gamma);
mu_int = cutSVTNN(SVTNN.mu, alpha, beta, gamma);

% Use midpoint of intervals for simulation
lambda = mean(lambda_int);
mu = mean(mu_int);

%% === System Configuration ===
C = 13;         % Total number of servers
K = 40;         % System capacity
D_vals = 1:6;   % Range of vacationing servers
Lq_vals = zeros(size(D_vals));

%% === Simulation: Lq vs D ===
for i = 1:length(D_vals)
    D = D_vals(i);
    c_eff = C - D;  % Active servers

    % Check system stability
    rho = lambda / (c_eff * mu);
    if rho >= 1
        Lq_vals(i) = NaN;
        continue;
    end

    % Approximate p0 using Erlang-like method
    sum_p = 0;
    for n = 0:(c_eff - 1)
        sum_p = sum_p + (lambda/mu)^n / factorial(n);
    end
    sum_p = sum_p + ((lambda/mu)^c_eff / factorial(c_eff)) * ...
        ((1 - (lambda/(c_eff*mu))^(K - c_eff + 1)) / ...
         (1 - (lambda/(c_eff*mu))));
    p0 = 1 / sum_p;

    % Queue length Lq (approximate formula for finite K)
    Lq_vals(i) = p0 * ((lambda/mu)^c_eff / factorial(c_eff)) * ...
        (rho / (1 - rho)^2);
end

%% === Plot Results ===
figure;
plot(D_vals, Lq_vals, '-o', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Number of Servers on Vacation (D)', 'FontSize', 12);
ylabel('Expected Queue Length (L_q)', 'FontSize', 12);
title('Queue Length vs Vacationing Servers (using SVTNN and αβγ-cut)', 'FontSize', 13);
grid on;

% Save the figure
saveas(gcf, 'queueLength_vs_D_SVTNN.png');

%% === Helper Function for (α, β, γ)-cut ===
function interval = cutSVTNN(svtnn, alpha, beta, gamma)
    % Truth cut (T)
    T1 = svtnn.T(1) + alpha * (svtnn.T(2) - svtnn.T(1));
    T2 = svtnn.T(4) - alpha * (svtnn.T(4) - svtnn.T(3));

    % Indeterminacy cut (I)
    I1 = svtnn.I(2) - beta * (svtnn.I(2) - svtnn.I(1));
    I2 = svtnn.I(3) + beta * (svtnn.I(4) - svtnn.I(3));

    % Falsity cut (F)
    F1 = svtnn.F(2) - gamma * (svtnn.F(2) - svtnn.F(1));
    F2 = svtnn.F(3) + gamma * (svtnn.F(4) - svtnn.F(3));

    % Combine: Conservative interval average
    interval = [(T1 + I1 + F1) / 3, (T2 + I2 + F2) / 3];
end
