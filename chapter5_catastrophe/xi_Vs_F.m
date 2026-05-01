%% Graph of reneging rate due to vacation Vs Expected total cost F
close all;
clear;
%%Fi=Fi(beta,lambda,mu,alpha,r,xi,eta,gamma,kappa,N);
%For beta=0.3; lambda=11.17; mu=19.9833; alpha=0.029; r=0.4; eta=0.0588; xi=0.015; D=6;gamma=0.02;kappa=0.8; N=89; 
xi=[0.019 0.018 0.017 0.016 0.016 0.015];
F=[42427.691626	42368.529597 42309.657552	42251.073382	42192.774997	42134.760330];
plot(xi,F,'black .-');
legend('ETC F');
xlabel('Mean reneging rate due to vacation (\xi)'); hold on
ylabel('Expected total cost (ETC) F'); hold on
%title('Average inventory level Vs average arriva rate'); hold on 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  



  
  