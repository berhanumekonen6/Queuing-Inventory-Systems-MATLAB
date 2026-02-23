function prob_1ns = P_1ns(b1,l,m,a,r1,s,e,N)
%a=0.2;b=0.01;e_I=0.01;s=0.001;N=10;
%l=10.25;
%m=19.9966
%C1=100;C2=110;C3=120;C4=150;C5=130;C6=140; %%Cost Elements
syms  n n1 r
C=13; D=4;
%rho=rho1+rho2
%rho1=((l*(1+b1))/(m+e)), s=1,2, ..., q
%rho2=((l*(1+b1))/(m)), s=q+1, q+2, ...,Q
%b1-beta
rho1=(l*(1+b1)/(m+e));
rho2=(l*(1+b1)/(m));
rho=rho1+rho2;
P_000 =double((((1+(rho)+symsum(((factorial(n))^-1*(rho)^n),n,2,C-D)+symsum((l*(1+b1))^n1/(m+s+e)*symprod((N-r+1)/(N*((m+s+e)+(r-(C-D+1))*(a*(1-r1)))),r,C-D+1,N),n1,C-D+1,N))))^-1);
prob_1ns =((l*(1+b1))^n1/(m+s+e)*symprod((N-r+1)/(N*((m+s)+(r-(C-D))*(a*(1-r1)))),r,C-D+1,N))*P_000;
end