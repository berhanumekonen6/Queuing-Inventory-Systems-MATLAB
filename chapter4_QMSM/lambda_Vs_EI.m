%% Graph of Arrival rate Vs Expected inventory E_I
close all;
clear;
%%Fi=Fi(beta,lambda,mu,alpha,r,xi,eta,N);
%For beta=0.5; lambda=11.17; mu=5.9101; alpha=0.029; r=0.9; eta=0.0588; xi=0.015; D=6; N=89; 
lambda=[11.17 11.2 11.23 11.26 11.29 11.32];
EI=[205.4764  114.0650   55.0347   22.7978    8.1025 2.5199];
plot(lambda,EI,'black .-');
legend('average inventory');
xlabel('Average arrival rate (\lambda)'); hold on
ylabel('Average inventory level (E_I)'); hold on
%title('Average inventory level Vs average arriva rate'); hold on 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  



  
  