%% Graph of Optimal service rate mu^* vs Optimal Cost F^*
close all;
clear;
%%Fi=Fi(b1,l,m,a,r1,s,e,N);
%For beta=0.5; lambda=11.17; alpha=0; r=0.9; eta=0.0588; xi=0.015; D=6; N=89; 
mu=[7.25 7 6.75 6.5 6.25 6 5.75 5.5];
F_1=[12845.5876	14153.5199	15593.2041	17175.7281	18912.5469	20815.3613	22895.9682	25166.0803];

%For beta=0.5; lambda=11.17; alpha=2.58; r=0.9; eta=0.0588; xi=0.015; D=6; N=89; 
F_2=[13846.5461	15154.605	16594.4348	18177.1268	19914.1399	21817.1801	24898.0499	26168.4696];
%For beta=0.5; lambda=11.17; alpha=0.029; r=0.9; eta=0.0588; xi=0.015; D=6; N=89;
%F_3=[];
subplot(2,2,1);
plot(mu,F_1,'black .-',mu,F_2,'black *-');
legend('\alpha = 0','\alpha \neq 0');
xlabel('Optimal service rate (\mu^{\ast})'); hold on
ylabel('Optimal cost loss F^\ast'); hold on
title('Optimal service rate Vs Optimal cost loss'); hold on 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%For beta=0; lambda=11.17; alpha=0.029; r=0.9; eta=0.0588; xi=0.015; D=6; N=89;
lambda=[11.17 11.2 11.23 11.26 11.29 11.32 11.35 11.38];    
F_4=[8058.4516	8128.9069	8199.63	8270.6191	8341.8725	8413.3885	8485.1655	8557.2016];
%For beta=0.5; lambda=11.17; alpha=0.029; r=0.9; eta=0.0588; xi=0.015; D=6; N=89;
F_5=[8346.0104	8424.532	8503.3136	8582.3531	8661.6485	8741.1977	8820.9987	8901.0495];
subplot(2,2,2)
plot(lambda,F_4,'black .-',lambda,F_5,'black *-');
legend('\beta = 0','\beta \neq 0');
xlabel('Arrival rate (\lambda)'); hold on
ylabel('Optimal cost loss (F^\ast)'); hold on
title('Arrival rate Vs Optimal cost loss'); hold on
  axis tight
  



  
  