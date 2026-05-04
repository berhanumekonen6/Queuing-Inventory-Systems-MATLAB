%% Graph of Optimal service rate mu^* vs Expected waiting times
close all;
clear;
%%Fi=Fi(beta,lambda,mu,alpha,r,xi,eta,N);
%For beta=0.5; lambda=11.17; alpha=0.029; r=0.9; eta=0.0588; xi=0.015; D=6; N=89; 
mu=[7.25 7 6.75 6.5 6.25 6 5.75 5.5];
Wq=[0.51429	0.56543	0.62176	0.6837	0.75172	0.82628	0.90786	0.99692];
plot(mu,Wq,'black .-');
legend('\beta = 0.5, \lambda = 11.17, \alpha = 0.029, r = 0.9; \eta = 0.0588, \xi = 0.015, D = 6');
xlabel('Expected number of custumers served (\mu^{\ast})'); hold on
ylabel('Expected waiting time (W_q)'); hold on
%title('Optimal service rate Vs Expecete waiting time'); hold on 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  



  
  