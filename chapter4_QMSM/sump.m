%%CHECK NORMALIZATION CONDITION (All probabilities sum to 1), N <=9000
function sum_of_prob = sump(b1,l,m,a,r1,s,e,N)
syms n n1 r 
C=13; D=4;  %%Indeed,D & m must be obtained from the herustic approach 
%%%n=C-D:1:N; (9-100) N=100.
rho1=(l*(1+b1)/(m+e));
rho2=(l*(1+b1)/(m));
rho=rho1+rho2;
P_000 =(((1+(rho)+symsum(((factorial(n))^-1*(rho)^n),n,2,C-D)+symsum((l*(1+b1))^n1/(m+s+e)*symprod((N-r+1)/(N*((m+s+e)+(r-(C-D+1))*(a*(1-r1)))),r,C-D+1,N),n1,C-D+1,N))))^-1;
P_01s=rho*P_000;  %%Since the number of servers in the system are 6 there is no reneging with existance of customers lessan 6.
P_0ns =((factorial(n))^-1)*(rho)^n*P_000; %% n=2:1:C-D
P_1ns =((l*(1+b1))^n1/(m+s+e)*symprod((N-r+1)/(N*((m+s)+(r-(C-D))*(a*(1-r1)))),r,C-D+1,N))*P_000; %% n=C-D+1:1:N
sum_of_prob= double((P_000+P_01s+symsum(P_0ns,n,2,C-D)+symsum(P_1ns,n1,C-D+1,N))); 
end