function Cost_Function=F_(new_mu) 
% Assign values for C, D, and N
C = 13;
D = 6;
N = 89;
% q=20  reordering level;
Q= 52 ;  %restocked level; Means inventory policy (0, q, Q)= (0, 20, 52)
s=20;
%I=50;
%s=1:Q;
% Assign numerical values to other parameters (You can replace with your actual values)
beta = 0.5;
lambda = 11.17;
%m = 7.25; from observed data 
alpha = 2.58;
r1 = 0.9;
xi = 1.33;
eta = 0.0588;
%phi =0.03;

C1=100;C2=110;C3=120;C4=150;C5=130;C6=140;C7=120; C8=56; C9=80;%%Cost Elements
syms n n1 new_mu r;
%%%%%%%%Steady state Probabilities%%%%%%%%%%%
%C=13; D=6;  %%Indeed,D & m must be obtained from the herustic approach
%% How can I optimize D & m at a time t?
%%%n=C-D:1:N; (4-10) N=10.
P_000 =(((1+(lambda*(1+beta)/new_mu+lambda/new_mu+eta)+symsum(((factorial(n))^-1*(lambda*(1+beta)/new_mu+lambda*(1+beta)/new_mu+eta)^n),n,2,C-D)+symsum((lambda*(1+beta))^n1/(new_mu+eta+xi)*symprod((N-r+1)/(N*((new_mu+eta+xi)+(r-(C-D+1))*alpha*(1-r1))),r,C-D+1,N),n1,C-D+1,N))))^-1;
P_0ns =(((factorial(n))^-1)*(lambda*(1+beta)/new_mu+lambda*(1+beta)/(new_mu+eta))^n)*P_000; %% n=1:1:C-D
P_0C_Ds=(((factorial(C-D))^-1)*(lambda*(1+beta)/new_mu+lambda*(1+beta)/(new_mu+eta))^(C-D))*P_000;
P_1ns =((((lambda*(1+beta))^n1)/(new_mu+eta+xi))*(symprod((N-r+1)/(N*((new_mu+eta+xi)+(r-(C-D+1))*alpha*(1-r1))),r,C-D+1,N)))*P_000; %% n=C-D:1:N
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EI=symsum(s*P_0ns,n,0,C-D-1)+symsum(s*P_1ns,n,C-D,N);
Er= symsum(eta*P_0ns,n,0,C-D-1)+symsum(eta*P_1ns,n,C-D,N);
E0=symsum(Q*P_0ns,n,0,C-D-1)+symsum((Q-s)*P_1ns,n,C-D,N);
VLr=symsum(n*xi*P_0ns,n,0,C-D);   %%% xi is reneging rate dute to vacation only.
P_B=P_0C_Ds+(symsum(P_1ns,n1,C-D+1,N)); %%%Busy prob. of the server and %%% Since only (C-D) servers are on duty.
P_I=symsum(P_0ns,n,0,C-D-1); 
Ls=(lambda/new_mu+lambda/(new_mu+eta))*P_000+(symsum(n*P_0ns,2,C-D-1))+symsum(n1*P_1ns,C-D,N);
Lq = (symsum((n1-(C-D))*P_1ns,n1,C-D+1,N));
BR=((1/N))*symsum(n1*n1*P_1ns,n1,C-D,N);   %%% How!!?
RR= (symsum((alpha*(1-r1)*(n1-(C-D)))*P_1ns,n1,C-D+1,N));
LR=(BR+RR);
GR=Ls-LR;
%%%%%%Total Expected Cost Function Interms of parameter "mu"%%%%%%%%%%%%%.
Cost_Function=C1 * EI + C2 * Er + C3 * E0 * Er + C4 * VLr + C5 * P_B + C6 * P_I + C7 * Lq + C8 * GR + C9 * LR;
end

