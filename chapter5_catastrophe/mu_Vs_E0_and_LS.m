%% Graph of Optimal service rate mu^* vs Expectednew orders
close all;
clear;
%%Fi=Fi(beta,lambda,mu,alpha,r,xi,eta,gamma,kappa,N);
%For beta=0.3; lambda=11.17; mu=19.9833; alpha=0.029; r=0.4; eta=0.0588; xi=0.015; D=6;gamma=0.02;kappa=0.8; N=89; 
mu=[7.25 7 6.75 6.5 6.25 6];
E0=[99.850604	91.361054	84.156846	77.969238	72.598873	67.894953];
LS=[10.170000	11.320000	12.476000	13.638000	14.806000	15.980000];
plot(mu,E0,'black .-',mu,LS,'black *-');
legend('mean new orders', 'mean lost sales');
xlabel('Mean number of custumers served (\mu)'); hold on
ylabel('Mean number of new orders and lost sales (E_0 and LS)'); hold on
%title('Optimal service rate Vs Expected new orders and Expected lost sales'); hold on 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  



  
  