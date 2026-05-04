%% Graph of Optimal service rate mu^* vs Expectednew orders
close all;
clear;
%%Fi=Fi(beta,lambda,mu,alpha,r,xi,eta,N);
%For beta=0.5; lambda=11.17; ;mu=5.9101; alpha=0.029; r=0.9; eta=0.0588; xi=0.015; D=6; N=89; 
mu=[5.5 5.75 6 6.25 6.5 6.75 7 7.25];
E0=[7.9151	8.0615	8.277	8.5667	8.9358	9.3894	9.9323	10.5693];
LS=[0.18552	0.16014	0.13698	0.11603	0.097236	0.080548	0.065882	0.053144];
plot(mu,E0,'black .-',mu,LS,'black *-');
legend('new orders', 'lost sales');
xlabel('Expected number of custumers served (\mu^{\ast})'); hold on
ylabel('Expected number of new orders and lost sales (E_0 and LS)'); hold on
%title('Optimal service rate Vs Expected new orders and Expected lost sales'); hold on 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  



  
  