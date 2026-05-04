%% Graph of Optimal service rate mu^* vs Expected waiting times
close all;
clear;
%%Fi=Fi(beta,lambda,mu,alpha,r,xi,eta,gamma,kappa,N);
%For beta=0.3; lambda=11.17; alpha=0.029; r=0.4; eta=0.0588; xi=0.015; D=6;gamma=0.02;kappa=0.8; N=89; 
mu=[7.25 7 6.75 6.5 6.25 6 5.75 5.5];
Wq1=[0.71429	0.76543	0.82176	0.8837	0.95172	1.02628	1.10786	1.19692];
Wq2=[0.51429	0.56543	0.62176	0.6837	0.75172	0.82628	0.90786	0.99692];
plot(mu,Wq1,'black .-',mu,Wq2,'black *-');
legend('\gamma = 0.02, \kappa = 0.8','\gamma = 0, \kappa = 0');
xlabel('Mean number of custumers served (\mu)'); hold on
ylabel('Mean waiting time in the queue ( W_q)'); hold on
%title('Optimal service rate Vs Expecete waiting time'); hold on 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  



  
  