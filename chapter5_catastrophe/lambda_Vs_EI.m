%% Graph of Arrival rate Vs Expected inventory E_I and Expected inventory destroyed
close all;
clear;
%%Fi=Fi(beta,lambda,mu,alpha,r,xi,eta,gamma,kappa,N);
%For beta=0.3; lambda=11.17; mu=19.9833; alpha=0.029; r=0.4; eta=0.0588; xi=0.015; D=6;gamma=0.02;kappa=0.8; N=89; 
lambda=[11.17 11.2 11.23 11.26 11.29 11.32];
EI=[103.926139	95.090076	87.591819	81.151656	75.562092	70.666176];
Ec=[101.847616	93.188275	85.839983	79.528623	74.050850	69.252852];
plot(lambda,EI,'black .-', lambda,Ec,'black *-');
legend('mean inventory level', 'mean inventory destroyed');
xlabel('Mean arrival rate (\lambda)'); hold on
ylabel('Mean inventory E_I and E_c '); hold on
%title('Average inventory level Vs average arriva rate'); hold on 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  



  
  