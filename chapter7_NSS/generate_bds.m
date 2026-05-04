%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Defines parameters for a neutrosophic multi-server queuing-inventory model
%Computes lower and upper bounds for L_q, L_s and W_q across \alpha \in [0,1]
%Uses simple approximations and includes plotting for each metric
%%%%%%%%

% Neutrosophic-Based Performance Metrics for NM/NM/C/K
% Parameters
C = 13;                 % Number of servers
lambda_crisp = 7.2;     % Crisp arrival rate
mu_crisp = 5.0;         % Service rate per server
K = 10;                 % Queue capacity

% Certainty levels
alpha = linspace(0, 1, 11);

% Initialize result vectors
lLq = zeros(1, length(alpha));
uLq = zeros(1, length(alpha));
lLs = zeros(1, length(alpha));
uLs = zeros(1, length(alpha));
lWq = zeros(1, length(alpha));
uWq = zeros(1, length(alpha));

% Neutrosophic Simulation over alpha cuts
for i = 1:length(alpha)
    a = alpha(i);
    
    % Adjust lambda and mu using uncertainty (10% spread)
    lam_low = lambda_crisp * (1 - 0.1 * a);
    lam_high = lambda_crisp * (1 + 0.1 * a);
    mu_low = mu_crisp * (1 - 0.1 * a);
    mu_high = mu_crisp * (1 + 0.1 * a);
    
    % Utilization
    rho_low = lam_low / (C * mu_high);
    rho_high = lam_high / (C * mu_low);
    
    % Avoid division by zero
    if rho_low >= 1, rho_low = 0.99; end
    if rho_high >= 1, rho_high = 0.99; end
    
    % Approximate performance metrics
    Lq_low = (rho_low^2) / (1 - rho_low + 1e-5);
    Lq_high = (rho_high^2) / (1 - rho_high + 1e-5);
    
    Ls_low = Lq_low + lam_low / mu_high;
    Ls_high = Lq_high + lam_high / mu_low;
    
    Wq_low = Lq_low / lam_low;
    Wq_high = Lq_high / lam_high;
    
    % Store
    lLq(i) = round(Lq_low, 5);
    uLq(i) = round(Lq_high, 5);
    lLs(i) = round(Ls_low, 5);
    uLs(i) = round(Ls_high, 5);
    lWq(i) = round(Wq_low, 5);
    uWq(i) = round(Wq_high, 5);
end

% Display result arrays
disp('Lower Bound Lq:'); disp(lLq);
disp('Upper Bound Lq:'); disp(uLq);
disp('Lower Bound Ls:'); disp(lLs);
disp('Upper Bound Ls:'); disp(uLs);
disp('Lower Bound Wq:'); disp(lWq);
disp('Upper Bound Wq:'); disp(uWq);

% Optional: Plot Lq, Ls, Wq
figure;
fill([alpha fliplr(alpha)], [lLq fliplr(uLq)], [0.7 0.9 1], 'EdgeColor','none'); hold on;
plot(alpha, lLq, 'b--o', 'DisplayName', 'Lower L_q');
plot(alpha, uLq, 'r--s', 'DisplayName', 'Upper L_q');
xlabel('\alpha (Certainty Level)'); ylabel('L_q'); title('Neutrosophic Bounds for L_q'); legend; grid on;

figure;
fill([alpha fliplr(alpha)], [lLs fliplr(uLs)], [0.7 1 0.7], 'EdgeColor','none'); hold on;
plot(alpha, lLs, 'b--o', 'DisplayName', 'Lower L_s');
plot(alpha, uLs, 'r--s', 'DisplayName', 'Upper L_s');
xlabel('\alpha (Certainty Level)'); ylabel('L_s'); title('Neutrosophic Bounds for L_s'); legend; grid on;

figure;
fill([alpha fliplr(alpha)], [lWq fliplr(uWq)], [1 0.9 0.7], 'EdgeColor','none'); hold on;
plot(alpha, lWq, 'b--o', 'DisplayName', 'Lower W_q');
plot(alpha, uWq, 'r--s', 'DisplayName', 'Upper W_q');
xlabel('\alpha (Certainty Level)'); ylabel('W_q'); title('Neutrosophic Bounds for W_q'); legend; grid on;
