%% Parameter Ranges
lambda_vals = [11.17, 11.20, 11.23, 11.26, 11.29, 11.32];
mu_vals     = [7.25, 7.00, 6.75, 6.50, 6.25, 6.00];

numCases = length(lambda_vals);

%% System Settings
numServers = 13;
maxCustomers = 30;

% Fixed model parameters (example, adjust as per your model)
D = 6;           % Number of servers on vacation
alpha = 0.029;   % Reneging rate
xi = 0.015;      % Vacation-related reneging
beta = 0.3;      % Attraction rate
r = 0.4;         % Retention rate
eta = 0.0588;    % Reordering rate
gamma = 0.02;    % Catastrophe rate
kappa = 0.8;     % Restoration rate
holdingCost = 1; % Example cost/unit inventory
waitingCost = 1; % Example cost/unit time in queue
penaltyCost = 1; % Example lost sale cost

%% Preallocate arrays for measures
EI_vals = zeros(1,numCases);
Er_vals = zeros(1,numCases);
E0_vals = zeros(1,numCases);
LS_vals = zeros(1,numCases);
Ls_vals = zeros(1,numCases);
Lq_vals = zeros(1,numCases);
Ws_vals = zeros(1,numCases);
Wq_vals = zeros(1,numCases);
LR_vals = zeros(1,numCases);
PB_vals = zeros(1,numCases);
PI_vals = zeros(1,numCases);
Ec_vals = zeros(1,numCases);
F_vals  = zeros(1,numCases);

customers = 0:maxCustomers;

%% Loop over all parameter cases
for i = 1:numCases
    lambda = lambda_vals(i);
    mu = mu_vals(i);

    %% Construct Q matrix (birth-death)
    Q = zeros(maxCustomers+1);
    for j = 1:maxCustomers+1
        if j <= maxCustomers
            Q(j,j+1) = lambda;
        end
        if j > 1
            Q(j,j-1) = min(j-1,numServers)*mu;
        end
        Q(j,j) = -sum(Q(j,:));
    end

    %% Solve steady-state probabilities
    A = [Q'; ones(1,maxCustomers+1)];
    b = [zeros(maxCustomers+1,1); 1];
    pi_ss = A\b;

    %% Performance measures

    % Lq and Wq
    Lq = sum(max(0,customers-numServers).*pi_ss');
    Wq = Lq / lambda;

    % Ls and Ws
    Ls = sum(customers.*pi_ss');
    Ws = Ls / lambda;

    % Server occupancy
    LS = sum(min(customers,numServers).*pi_ss');

    % Idle probability
    PI = pi_ss(1);

    % Probability system is empty
    E0 = pi_ss(1);

    % Blocking probability (full system)
    PB = pi_ss(end);

    % Lost revenue/customers (example: customers > maxServers)
    LR = sum(max(0,customers-numServers).*pi_ss');

    % Example: reneging probability (simplified as proportion of waiting customers)
    Er = sum(alpha .* max(0,customers-numServers) .* pi_ss');

    % Example: mean inventory (replace with your inventory states if modeled)
    EI = sum(D .* pi_ss');  % Simple placeholder

    % Total cost (example formula)
    Ec = holdingCost*Ls + waitingCost*Lq + penaltyCost*LR;

    % Expected total cost (F)
    F = Ec;  % If you have a more detailed formula, replace this

    %% Store results
    EI_vals(i) = EI;
    Er_vals(i) = Er;
    E0_vals(i) = E0;
    LS_vals(i) = LS;
    Ls_vals(i) = Ls;
    Lq_vals(i) = Lq;
    Ws_vals(i) = Ws;
    Wq_vals(i) = Wq;
    LR_vals(i) = LR;
    PB_vals(i) = PB;
    PI_vals(i) = PI;
    Ec_vals(i) = Ec;
    F_vals(i) = F;
end

%% Create MATLAB table
T = table(lambda_vals', mu_vals', EI_vals', Er_vals', E0_vals', LS_vals', ...
          Ls_vals', Lq_vals', Ws_vals', Wq_vals', LR_vals', PB_vals', PI_vals', ...
          Ec_vals', F_vals', ...
    'VariableNames', {'Lambda','Mu','EI','Er','E0','LS','Ls','Lq','Ws','Wq','LR','PB','PI','Ec','F'});

disp(T);
