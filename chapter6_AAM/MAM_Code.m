%% M/M/C/K Queue with Inventory, Vacations, and Catastrophes
% Complete implementation of performance measures (6.18-6.35)
% Author: M/M/C/K Queue Model
% Date: 2024

clear; clc;
close all;

%% Parameter Ranges
lambda_vals = [11.17, 11.20, 11.23, 11.26, 11.29, 11.32];
mu_vals     = [7.25, 7.00, 6.75, 6.50, 6.25, 6.00];

numCases = length(lambda_vals);

%% System Settings
C = 13;              % Total servers
D = 6;               % Number of servers on vacation
activeServers = C - D;  % C-D = 7 active servers

% Choose system capacity (N)
% N = 30;   % Faster computation, stable
N = 89;              % Maximum customers in system (as per your requirement)

maxCustomers = N;
Q_max = 30;          % Maximum inventory level (Q)
q = 5;               % Reorder point (0 <= q <= Q_max)

% Fixed model parameters
gamma_attraction = 0.3;  % Attraction rate (β)
alpha = 0.029;      % Reneging rate
xi = 0.015;         % Vacation-related reneging
r = 0.4;            % Retention rate
eta = 0.0588;       % Reordering rate
gamma_catastrophe = 0.02;  % Catastrophe rate
kappa = 0.8;        % Vacation end rate (restoration)

% Cost parameters
C_1 = 100;   % holding cost of inventory per unit time
C_2 = 110;   % fixed cost for placing an order
C_3 = 120;   % replenishment cost per item
C_4 = 150;   % cost per unit time when server is on vacation
C_5 = 130;   % cost per unit time when server is busy
C_6 = 140;   % cost per unit time when server is idle
C_7 = 120;   % cost per unit time when customer waits
C_8 = 56;    % cost per unit time when customer is served
C_9 = 80;    % cost per unit time when customer balks/reneges
C_10 = 200;  % cost per unit time when catastrophe happens

%% Balking probability function b_n
% b_n = probability an arriving customer joins the queue
% For 0 ≤ n ≤ C-D-1: b_n = 1-γ
% For C-D ≤ n ≤ N: b_n = ((N-n)/N)*(1-γ)
b_n = zeros(1, maxCustomers+1);
for n = 0:maxCustomers
    if n <= activeServers - 1
        b_n(n+1) = 1 - gamma_attraction;
    elseif n <= maxCustomers
        b_n(n+1) = ((maxCustomers - n) / maxCustomers) * (1 - gamma_attraction);
    end
end
b_n = max(b_n, 0);

%% Preallocate arrays for all performance measures
EI_vals = zeros(1,numCases);
Er_vals = zeros(1,numCases);
E0_vals = zeros(1,numCases);
LS_vals = zeros(1,numCases);
Ls_vals = zeros(1,numCases);
Lq_vals = zeros(1,numCases);
Ws_vals = zeros(1,numCases);
Wq_vals = zeros(1,numCases);
PB_vals = zeros(1,numCases);
PI_vals = zeros(1,numCases);
beta1_vals = zeros(1,numCases);
lambda_eff_vals = zeros(1,numCases);
BR_vals = zeros(1,numCases);
RR_vals = zeros(1,numCases);
LR_vals = zeros(1,numCases);
GR_vals = zeros(1,numCases);
VLr_vals = zeros(1,numCases);
Ec_vals = zeros(1,numCases);
F_vals = zeros(1,numCases);

%% State mapping function
% State (phase, n, s) where:
%   phase = 0: servers on vacation
%   phase = 1: servers active
%   n = 0..maxCustomers (customers in system)
%   s = 0..Q_max (inventory level)
numPhases = 2;
numStates = numPhases * (maxCustomers+1) * (Q_max+1);

stateIndex = @(phase, n, s) (phase * (maxCustomers+1) * (Q_max+1)) + ...
                             (n * (Q_max+1)) + s + 1;

fprintf('=== System Configuration ===\n');
fprintf('Total servers (C): %d\n', C);
fprintf('Vacation servers (D): %d\n', D);
fprintf('Active servers (C-D): %d\n', activeServers);
fprintf('Maximum customers (N): %d\n', maxCustomers);
fprintf('Maximum inventory (Q): %d\n', Q_max);
fprintf('Reorder point (q): %d\n', q);
fprintf('Attraction rate (γ): %.2f\n', gamma_attraction);
fprintf('Balking function: b_n = %.2f for n = 0..%d\n', 1-gamma_attraction, activeServers-1);
fprintf('b_n = ((%d-n)/%d)*%.2f for n = %d..%d\n', maxCustomers, maxCustomers, 1-gamma_attraction, activeServers, maxCustomers);
fprintf('Total number of states: %d\n\n', numStates);

%% Main loop over parameter cases
for caseIdx = 1:numCases
    lambda = lambda_vals(caseIdx);
    mu = mu_vals(caseIdx);
    
    fprintf('Processing case %d/%d: λ=%.2f, μ=%.2f\n', ...
        caseIdx, numCases, lambda, mu);
    
    tic; % Start timer
    
    %% Initialize sparse transition rate matrix
    Q = sparse(numStates, numStates);
    
    %% Build transition rates
    for phase = 0:1
        for n = 0:maxCustomers
            for s = 0:Q_max
                idx = stateIndex(phase, n, s);
                
                % ===== ARRIVAL RATES =====
                if n < maxCustomers
                    if s > 0  % Has inventory
                        if phase == 1 && n >= activeServers
                            % Balking possible in active phase when queue exists
                            arrival_rate = lambda * (1 + gamma_attraction) * b_n(n+1);
                        elseif phase == 1 && n < activeServers
                            % No balking when servers are idle
                            arrival_rate = lambda * (1 + gamma_attraction);
                        else
                            % Phase 0 (vacation) or other cases
                            arrival_rate = lambda * (1 + gamma_attraction);
                        end
                    else
                        % No inventory - no balking/attraction
                        arrival_rate = lambda;
                    end
                    next_idx = stateIndex(phase, n+1, s);
                    Q(idx, next_idx) = arrival_rate;
                end
                
                % ===== SERVICE RATES =====
                if n > 0
                    % Calculate service rate based on phase
                    if phase == 0
                        % Vacation phase: only D servers working (slower)
                        service_rate = min(n, D) * mu * 0.3;
                    else
                        % Active phase: all active servers working
                        service_rate = min(n, activeServers) * mu;
                    end
                    
                    % Determine next state after service
                    if phase == 1 && s > 0 && s <= q
                        % Reorder triggered: inventory replenished to Q_max
                        next_idx = stateIndex(phase, n-1, Q_max);
                        Q(idx, next_idx) = Q(idx, next_idx) + service_rate;
                    elseif s > 0
                        % Normal service with inventory consumption
                        next_idx = stateIndex(phase, n-1, s-1);
                        Q(idx, next_idx) = Q(idx, next_idx) + service_rate;
                    else
                        % Service with no inventory (customers still served)
                        next_idx = stateIndex(phase, n-1, s);
                        Q(idx, next_idx) = Q(idx, next_idx) + service_rate;
                    end
                end
                
                % ===== PHASE TRANSITIONS =====
                % End vacation (vacation -> active)
                if phase == 0 && n > 0 && s <= q
                    next_idx = stateIndex(1, n, s);
                    Q(idx, next_idx) = kappa;
                end
                
                % Start vacation (active -> vacation)
                if phase == 1 && n == 0 && s >= Q_max/2
                    next_idx = stateIndex(0, n, s);
                    Q(idx, next_idx) = xi;
                end
                
                % ===== CUSTOMER RENEGING =====
                if phase == 1 && n > activeServers
                    renege_rate = alpha * (1 - r) * (n - activeServers);
                    next_idx = stateIndex(phase, n-1, s);
                    Q(idx, next_idx) = renege_rate;
                end
                
                % ===== VACATION-INDUCED RENEGING =====
                if phase == 0 && n > 0
                    vacation_renege = xi * n;
                    next_idx = stateIndex(phase, n-1, s);
                    Q(idx, next_idx) = vacation_renege;
                end
                
                % ===== CATASTROPHE =====
                if s > 0
                    % Catastrophe destroys all inventory
                    next_idx = stateIndex(phase, n, 0);
                    Q(idx, next_idx) = gamma_catastrophe;
                end
            end
        end
    end
    
    % Set diagonal elements (negative sum of outgoing rates)
    for i_state = 1:numStates
        Q(i_state, i_state) = -sum(Q(i_state, :));
    end
    
    %% Solve steady-state probabilities
    A = [Q'; ones(1, numStates)];
    b = [zeros(numStates, 1); 1];
    
    % Use sparse solver
    pi_vec = A\b;
    
    % Eliminate tiny negative values due to numerical errors
    pi_vec = max(pi_vec, 0);
    pi_vec = pi_vec / sum(pi_vec);
    
    % Reshape into 3D array: p(phase, n, s)
    p = zeros(2, maxCustomers+1, Q_max+1);
    for phase = 0:1
        for n = 0:maxCustomers
            for s = 0:Q_max
                idx = stateIndex(phase, n, s);
                p(phase+1, n+1, s+1) = pi_vec(idx);
            end
        end
    end
    
    % Check probability distribution
    prob_by_n = squeeze(sum(sum(p, 1), 3));
    [max_prob, max_n] = max(prob_by_n);
    fprintf('  Max probability at n=%d (p=%.4f)\n', max_n-1, max_prob);
    
    %% Compute performance measures (equations 6.18-6.35)
    
    % 6.18: Mean inventory level (EI)
    EI = 0;
    for s = 0:Q_max
        for n = 0:activeServers
            EI = EI + s * p(1, n+1, s+1);
        end
        for n = activeServers+1:maxCustomers
            EI = EI + s * p(2, n+1, s+1);
        end
    end
    
    % 6.19: Mean reorder rate (Er)
    Er = 0;
    for s = 0:q
        for n = 0:activeServers
            Er = Er + eta * p(1, n+1, s+1);
        end
        for n = activeServers+1:maxCustomers
            Er = Er + eta * p(2, n+1, s+1);
        end
    end
    
    % 6.20: Mean order size (E0)
    E0 = 0;
    for n = 0:activeServers
        E0 = E0 + Q_max * p(1, n+1, 0+1);
    end
    for s = 0:q
        for n = activeServers+1:maxCustomers
            E0 = E0 + (Q_max - s) * p(2, n+1, s+1);
        end
    end
    
    % 6.21: Mean loss rate (LS)
    LS_loss = 0;
    for n = 0:activeServers
        LS_loss = LS_loss + p(1, n+1, 0+1);
    end
    for s = 1:Q_max
        LS_loss = LS_loss + p(2, maxCustomers+1, s+1);
    end
    LS = lambda * (1 + gamma_attraction) * LS_loss;
    
    % 6.22-6.23: Service level and effective arrival rate
    lambda_eff = lambda * (1 + gamma_attraction) - LS;
    if lambda * (1 + gamma_attraction) > 0
        beta1 = lambda_eff / (lambda * (1 + gamma_attraction));
    else
        beta1 = 0;
    end
    
    % 6.24: Mean system length (Ls)
    Ls = 0;
    for s = 0:Q_max
        for n = 1:activeServers
            Ls = Ls + n * p(1, n+1, s+1);
        end
        for n = activeServers+1:maxCustomers
            Ls = Ls + n * p(2, n+1, s+1);
        end
    end
    
    % 6.25: Mean queue length (Lq)
    Lq = 0;
    for s = 0:Q_max
        for n = activeServers+1:maxCustomers
            Lq = Lq + (n - activeServers) * p(2, n+1, s+1);
        end
    end
    
    % 6.26-6.27: Mean waiting times (Little's Law)
    if lambda_eff > 1e-10
        Ws = Ls / lambda_eff;
        Wq = Lq / lambda_eff;
    else
        Ws = 0;
        Wq = 0;
    end
    
    % 6.28: Busy probability (PB) - all active servers busy
    PB = 0;
    for s = 1:Q_max
        for n = activeServers:maxCustomers
            PB = PB + p(2, n+1, s+1);
        end
    end
    
    % 6.29: Idle probability (PI)
    PI = 0;
    for s = 0:Q_max
        for n = 0:activeServers-1
            PI = PI + p(1, n+1, s+1);
        end
    end
    for n = activeServers:maxCustomers
        PI = PI + p(2, n+1, 0+1);
    end
    
    % 6.30: Balking rate (BR)
    BR = 0;
    for s = 0:Q_max
        for n = activeServers:maxCustomers
            BR = BR + (1 - b_n(n+1)) * p(2, n+1, s+1);
        end
    end
    BR = lambda * (1 + gamma_attraction) * BR;
    
    % 6.31: Reneging rate (RR)
    RR = 0;
    for s = 0:Q_max
        for n = activeServers+1:maxCustomers
            RR = RR + (n - activeServers) * p(2, n+1, s+1);
        end
    end
    RR = alpha * (1 - r) * RR;
    
    % 6.32: Total loss rate (LR)
    LR = BR + RR;
    
    % 6.33: Good customers served (GR)
    GR = Ls - LR;
    if GR < 0
        GR = 0;
    end
    
    % 6.34: Vacation loss rate (VLr)
    VLr = 0;
    for s = 0:Q_max
        for n = 0:activeServers
            VLr = VLr + n * p(1, n+1, s+1);
        end
    end
    VLr = xi * VLr;
    
    % 6.35: Catastrophe loss (Ec)
    Ec = 0;
    for s = 0:Q_max
        for n = 0:activeServers
            Ec = Ec + s * gamma_catastrophe * p(1, n+1, s+1);
        end
        for n = activeServers+1:maxCustomers
            Ec = Ec + s * gamma_catastrophe * p(2, n+1, s+1);
        end
    end
    
    % Total expected cost (F)
    F = C_1 * EI + C_2 * Er + C_3 * E0 + C_4 * VLr + ...
        C_5 * PB + C_6 * PI + C_7 * Lq + C_8 * GR + C_9 * LR + C_10 * Ec;
    
    %% Store results
    EI_vals(caseIdx) = EI;
    Er_vals(caseIdx) = Er;
    E0_vals(caseIdx) = E0;
    LS_vals(caseIdx) = LS;
    Ls_vals(caseIdx) = Ls;
    Lq_vals(caseIdx) = Lq;
    Ws_vals(caseIdx) = Ws;
    Wq_vals(caseIdx) = Wq;
    PB_vals(caseIdx) = PB;
    PI_vals(caseIdx) = PI;
    beta1_vals(caseIdx) = beta1;
    lambda_eff_vals(caseIdx) = lambda_eff;
    BR_vals(caseIdx) = BR;
    RR_vals(caseIdx) = RR;
    LR_vals(caseIdx) = LR;
    GR_vals(caseIdx) = GR;
    VLr_vals(caseIdx) = VLr;
    Ec_vals(caseIdx) = Ec;
    F_vals(caseIdx) = F;
    
    elapsed_time = toc;
    fprintf('  EI=%.4f, Er=%.4f, Ls=%.2f, Lq=%.2f, β1=%.4f, F=%.2f (Time: %.2f sec)\n', ...
        EI, Er, Ls, Lq, beta1, F, elapsed_time);
end

%% Create results table
fprintf('\n=== FINAL RESULTS ===\n');

T = table(lambda_vals', mu_vals', EI_vals', Er_vals', E0_vals', LS_vals', ...
          Ls_vals', Lq_vals', Ws_vals', Wq_vals', PB_vals', PI_vals', ...
          beta1_vals', lambda_eff_vals', BR_vals', RR_vals', LR_vals', ...
          GR_vals', VLr_vals', Ec_vals', F_vals', ...
    'VariableNames', {'Lambda', 'Mu', 'EI', 'Er', 'E0', 'LS', 'Ls', 'Lq', ...
                      'Ws', 'Wq', 'PB', 'PI', 'Beta1', 'Lambda_eff', ...
                      'BR', 'RR', 'LR', 'GR', 'VLr', 'Ec', 'F'});

disp(T);

%% Save results to file
filename = sprintf('MAM_Results_N%d_%s.mat', maxCustomers, datestr(now, 'yyyymmdd_HHMMSS'));
save(filename, 'T', 'lambda_vals', 'mu_vals', 'EI_vals', 'Er_vals', 'E0_vals', ...
     'LS_vals', 'Ls_vals', 'Lq_vals', 'Ws_vals', 'Wq_vals', 'PB_vals', ...
     'PI_vals', 'beta1_vals', 'lambda_eff_vals', 'BR_vals', 'RR_vals', ...
     'LR_vals', 'GR_vals', 'VLr_vals', 'Ec_vals', 'F_vals');
fprintf('\nResults saved to: %s\n', filename);

%% Export to CSV
csv_filename = strrep(filename, '.mat', '.csv');
writetable(T, csv_filename);
fprintf('Results also saved to: %s\n', csv_filename);

%% Summary statistics
fprintf('\n=== SUMMARY STATISTICS ===\n');
fprintf('Maximum customers (N): %d\n', maxCustomers);
fprintf('Active servers (C-D): %d\n', activeServers);
fprintf('Queue capacity: %d\n', maxCustomers - activeServers);
fprintf('\nAverage EI: %.4f\n', mean(EI_vals));
fprintf('Average Er: %.4f\n', mean(Er_vals));
fprintf('Average E0: %.4f\n', mean(E0_vals));
fprintf('Average LS: %.4f\n', mean(LS_vals));
fprintf('Average Ls: %.2f\n', mean(Ls_vals));
fprintf('Average Lq: %.2f\n', mean(Lq_vals));
fprintf('Average Ws: %.4f\n', mean(Ws_vals));
fprintf('Average Wq: %.4f\n', mean(Wq_vals));
fprintf('Average PB: %.4f\n', mean(PB_vals));
fprintf('Average PI: %.4f\n', mean(PI_vals));
fprintf('Average Beta1: %.4f\n', mean(beta1_vals));
fprintf('Average Lambda_eff: %.4f\n', mean(lambda_eff_vals));
fprintf('Average BR: %.4f\n', mean(BR_vals));
fprintf('Average RR: %.4f\n', mean(RR_vals));
fprintf('Average LR: %.4f\n', mean(LR_vals));
fprintf('Average GR: %.4f\n', mean(GR_vals));
fprintf('Average VLr: %.4f\n', mean(VLr_vals));
fprintf('Average Ec: %.4f\n', mean(Ec_vals));
fprintf('Average Total Cost F: %.2f\n', mean(F_vals));

%% Plot key results
figure('Position', [100, 100, 1600, 900]);

% Row 1: Queue measures
subplot(2,4,1);
plot(lambda_vals, Ls_vals, 'b-o', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('\lambda');
ylabel('L_s');
title('Mean System Length');
grid on;

subplot(2,4,2);
plot(lambda_vals, Lq_vals, 'r-o', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('\lambda');
ylabel('L_q');
title('Mean Queue Length');
grid on;

subplot(2,4,3);
plot(lambda_vals, beta1_vals, 'g-o', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('\lambda');
ylabel('\beta_1');
title('Service Level');
grid on;
ylim([0 1]);

subplot(2,4,4);
plot(lambda_vals, F_vals, 'm-o', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('\lambda');
ylabel('F');
title('Total Expected Cost');
grid on;

% Row 2: Inventory measures
subplot(2,4,5);
plot(lambda_vals, EI_vals, 'c-o', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('\lambda');
ylabel('E_I');
title('Mean Inventory Level');
grid on;

subplot(2,4,6);
plot(lambda_vals, Er_vals, 'k-o', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('\lambda');
ylabel('E_r');
title('Mean Reorder Rate');
grid on;

subplot(2,4,7);
plot(lambda_vals, lambda_eff_vals, 'r--o', 'LineWidth', 2, 'MarkerSize', 8);
hold on;
plot(lambda_vals, lambda_vals*(1+gamma_attraction), 'b-', 'LineWidth', 1.5);
xlabel('\lambda');
ylabel('\lambda_{eff}');
title('Effective Arrival Rate');
legend('\lambda_{eff}', '\lambda(1+\gamma)', 'Location', 'best');
grid on;
hold off;

subplot(2,4,8);
plot(lambda_vals, [BR_vals; RR_vals; LR_vals]', 'o-', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('\lambda');
ylabel('Rate');
title('Loss Rates');
legend('BR', 'RR', 'LR', 'Location', 'best');
grid on;

sgtitle(sprintf('Performance Measures vs Arrival Rate (N=%d, C-D=%d, Q=%d, q=%d)', ...
    maxCustomers, activeServers, Q_max, q));

%% Print balking probabilities for verification
fprintf('\n=== BALKING PROBABILITY VERIFICATION ===\n');
fprintf('γ (attraction rate) = %.2f\n', gamma_attraction);
fprintf('1-γ = %.2f\n', 1-gamma_attraction);
fprintf('N = %d\n', maxCustomers);
fprintf('\n n\t b_n\n');
fprintf('---\t -----\n');
test_n = [0, activeServers-1, activeServers, activeServers+5, floor(maxCustomers/2), maxCustomers-10, maxCustomers-5, maxCustomers];
for n = test_n
    if n >= 0 && n <= maxCustomers
        fprintf('%3d\t %.6f\n', n, b_n(n+1));
    end
end

fprintf('\n=== PROGRAM COMPLETED SUCCESSFULLY ===\n');
fprintf('Total states processed: %d\n', numStates * numCases);
fprintf('All results saved to .mat and .csv files\n');