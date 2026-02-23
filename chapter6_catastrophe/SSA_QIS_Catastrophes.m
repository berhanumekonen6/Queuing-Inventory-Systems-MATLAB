%syms lambda mu eta xi beta alpha r  % Declare symbolic variables
syms n
% Assign values for C, D, and N
C = 13;
D = 6;  % 6 5 4 3 2 1 (from observed data we get average of 6.0625 ~ 6 servers go for vacation)  
N = 89;
% q=20  reordering level;
Q= 50;  %restocked level; Means inventory policy (0, q, Q)= (0, 20, 50) obtained by direct interview@ET (for two weeks study period)  
I=20;
s=1:Q;
% Assign numerical values to other parameters (replace with your actual values)
beta = 0.5; %for &0  &0.1 &0.2 &0.3 &0.4 & 0.5 \\ 
lambda = 11.17; %for 11.17 11.2 11.23 11.26 11.29 11.32  %lambda= 11.17 from observed data
mu = 6;  %for 7.25 7 6.75 6.5 6.25 6  %mu=5.9101 ~ 6, F(mu)=502.3490 from model solution and mu=7.25 from observed data
alpha = 0.029; %for &0.024 &0.025 &0.026 &0.027 &0.028 &0.029 %%Observed data 2.58/89=0.029  
r = 0.4;  %for &0.9 &0.8 &0.7 &0.6 &0.5 &0.4    
xi = 0.014; %&0.019 &0.018 &0.017 &0.016 &0.015 &0.014 %%Observed data 1.33/89=0.015
eta = 0.0588;  %%from observed data
gamma=0.02;
kappa=0.8;
%phi =0.03;
% Calculate intermediate variables (using symsum for L)
rho = lambda * (1 + beta) / (mu + eta + kappa);
L = 1 + rho + symsum((rho^n)/factorial(n), n, 2, C-D);

% Calculate b_i values recursively
b = sym('b', [1, N]);
b(1:C-D) = 1*(1-gamma);
b(C-D+1:N) = ((N - (C-D:N-1)) / N)*(1-gamma);
for i = C-D+1:N-1
    b_i= b(i-1) / (mu + eta + kappa+ (i - (C-D)) * alpha * (1 - r) + xi);
end

% Calculate all probabilities using symsum
p_0_0_0 = ((L + symsum((lambda * (1 + beta))^n / (mu + eta + kappa + xi) * prod(b(C-D+1:N-1)), n, C-D, N-1) + (lambda * (1 + beta))^N / (mu + eta + kappa + xi) * prod(b(C-D+1:N-1))))^-1;
p_0_1_s = rho * p_0_0_0;
p_0_n_s = (rho^n * p_0_0_0) / factorial(n);  % For n = 2 to C-D
p_1_1_s = (lambda * (1 + beta)) / (mu + eta + kappa + xi) * prod(b(2:N-1)) * p_0_0_0;
p_1_n_s = (lambda * (1 + beta))^n / (mu + eta + kappa + xi) * prod(b(C-D+1:N-1)) * p_0_0_0;
p_1_N_s = (lambda * (1 + beta))^N / (mu + eta + kappa + xi) * prod(b(C-D+1:N-1)) * p_0_0_0;

% Calculate the sum of probabilities
%total_prob = p_0_0_0 + p_0_1_s + sum(p_0_n_s, 2, C-D) + p_1_1_s + sum(p_1_n_s, C-D+1, N-1) + p_1_N_s;

% Display probabilities and their sum
disp('Probabilities (numerical values):')
disp(['p_0_0_0 = ', num2str(double(p_0_0_0))])
disp(['p_0_1_s = ', num2str(double(p_0_1_s))])

% Evaluate p_0_n_s for n = 2 to C-D and display
for n = 2:C-D
   p_0_n_s_value = double(subs(p_0_n_s, n));  % Evaluate for specific n
   disp(['p_0_n_s (n = ', num2str(n), ') = ', num2str(p_0_n_s_value)])
end

disp(['p_1_1_s = ', num2str(double(p_1_1_s))])

% Evaluate p_1_n_s for n = C-D+1 to N-1 and display
for n = C-D+1:N-1
   p_1_n_s_value = double(subs(p_1_n_s, n));  % Evaluate for specific n
   disp(['p_1_n_s (n = ', num2str(n), ') = ', num2str(p_1_n_s_value)])
end

disp(['p_1_N_s = ', num2str(double(p_1_N_s))])

% Display the sum of probabilities
sum_p_0_n_s = 0;  % Initialize a variable to store the sum
for n = 2:C-D
   p_0_n_s_value = double(subs(p_0_n_s, n));  % Evaluate p_0_n_s for specific n
   %disp(['p_0_n_s (n = ', num2str(n), ') = ', num2str(p_0_n_s_value)])
   sum_p_0_n_s = sum_p_0_n_s + p_0_n_s_value;  % Add the evaluated value to the sum
end
%sum_p_0_n_s;

 sum_p_1_n_s = 0;  % Initialize a variable to store the sum
for n = C-D+1:N-1
   p_1_n_s_value = double(subs(p_1_n_s, n));  % Evaluate p_1_n_s for specific n
   %disp(['p_1_n_s (n = ', num2str(n), ') = ', num2str(p_1_n_s_value)])
   sum_p_1_n_s = sum_p_1_n_s + p_1_n_s_value;  % Add the evaluated value to the sum
end
%sum_p_1_n_s;
% Calculate the sum of probabilities
total_prob = double(p_0_0_0 + p_0_1_s + sum_p_0_n_s + p_1_1_s + sum_p_1_n_s + p_1_N_s); 
 disp(['Sum_of_Prob = ', num2str(double(total_prob))])

% Evaluate performance measures
EI = double(p_0_0_0)+2*double(p_0_1_s)+sum(sum(s .* p_0_n_s_value, 2), 2) + sum(sum(s .* p_1_n_s_value, 2), 2);
Er = eta*double((p_0_0_0)+(p_0_1_s))+eta * (sum(sum(p_0_n_s_value, 2), 2) + sum(sum(p_1_n_s_value, 2), 2));
E0 = Q*double((p_0_0_0)+(p_0_1_s))+sum(Q * p_0_n_s_value, 2) + sum(sum((Q - s) .* p_1_n_s_value, 2), 2);
LS = lambda * (1 + beta) * double((p_0_0_0 + p_1_N_s));
LSc = LS /Er;
% ... (calculate s based on its definition)
alpha_1 = 1 - exp(-lambda * (Q - I));  % Assuming I is known
beta1 = (lambda * (1 + beta) - LS) / (lambda * (1 + beta));
% ... (calculate LS_I if needed for betaI)
lambda_eff = lambda * (1 + beta) * beta1;
Ls = double(0*(p_0_0_0)+1*(p_0_1_s))+sum(sum(n .* p_0_n_s_value, 2), C-D-1) + sum(sum(n .* p_1_n_s_value, C-D), N-1)+(N)*double(p_1_N_s);
Lq = double(p_0_1_s)+sum(sum((n - (C - D)) .* p_1_n_s_value, C-D+2), N-1)+(N-C+D)*double(p_1_N_s);
Ws = Ls / lambda_eff;
Wq = Lq / lambda_eff;
PB = sum(sum(p_0_n_s_value, C-D), C-D)+ sum(sum(p_1_n_s_value, C-D+1), N-1)+ double(p_1_N_s);
%PI = double((p_0_0_0)+(p_0_1_s))+sum(sum(p_0_n_s_value, 2), C-D-1) ;
PI=1-PB;
BR =double(lambda * (1 + beta)*(1 - b(C-D+1:C-D+1))*sum(sum(p_0_n_s_value, C-D), C-D)) +double(lambda * (1 + beta) * sum(sum((1 - b(C-D+1:N)) .* p_1_n_s_value, 2), 2));
RR = alpha * (1 - r) *sum(sum(p_0_n_s_value, C-D), C-D)+ alpha * (1 - r) * sum(sum((n - C + D) .* p_1_n_s_value, 2), 2);
LR = BR + RR;
GR = Ls - RR;
VLr = xi*double(p_0_1_s)+xi * sum(sum(n .* p_0_n_s_value, 2), 2);
Ec = double(p_0_0_0)+2*double(p_0_1_s)+sum(sum(s*(1-gamma) .* p_0_n_s_value, 2), 2) + sum(sum(s*(1-gamma) .* p_1_n_s_value, 2), 2);
%Total Cost function (mu, D)
%syms mu D % Declare symbolic variables
C1=100;C2=110;C3=120;C4=150;C5=130;C6=140;C7=120; C8=56; C9=80; C10=200; %%Cost Elements
F = C1 * EI + C2 * Er + C3 * E0 * Er + C4 * VLr + C5 * PB + C6 * PI + C7 * Lq + C8 * GR + C9 * LR +C10* Ec;

% % % Display performance measures
% disp('Performance Measures:')
% disp(['EI = ', num2str(EI)])
% disp(['Er = ', num2str(Er)])
% disp(['E0 = ', num2str(E0)])
% disp(['LS = ', num2str(LS)])
% disp(['LSc = ', num2str(LSc)])
% %disp(['s = ', num2str(s)])  % Replace with the calculated value of s
% %disp(['alpha_1 = ', num2str(alpha_1)])
% disp(['beta1 = ', num2str(beta1)])
% disp(['lambda_eff = ', num2str(lambda_eff)])
% disp(['Ls = ', num2str(Ls)])
% disp(['Lq = ', num2str(Lq)])
% disp(['Ws = ', num2str(Ws)])
% disp(['Wq = ', num2str(Wq)])
% disp(['PB = ', num2str(PB)])
% disp(['PI = ', num2str(PI)])
% disp(['BR = ', num2str(BR)])
% disp(['RR = ', num2str(RR)])
% disp(['LR = ', num2str(LR)])
% disp(['GR = ', num2str(GR)])
% disp(['VLr = ', num2str(VLr)])
% disp(['Ec = ', num2str(Ec)])
% disp(['F = ', num2str(F)])

% Display performance measures with formatting
disp('Performance Measures (6 decimal places):')
disp([num2str(EI, '%6.6f')])
disp([num2str(Er, '%6.6f')])
disp([num2str(E0,'%6.6f')])
disp([num2str(LS,'%6.6f')])
disp([num2str(Ls,'%6.6f')])
disp([num2str(Lq,'%6.6f')])
disp([num2str(Ws,'%6.6f')])
disp([num2str(Wq,'%6.6f')])
disp([num2str(LR,'%6.6f')])
disp([num2str(PB,'%6.6f')])
disp([num2str(PI,'%6.6f')])
disp([num2str(Ec,'%6.6f')])
disp([num2str(F,'%6.6f')])
