%Recorded Data@Monday
C=13;
A_Times_M	=[];
Num_arrivals_M=[1
1
2
4
2
1
3
1
5
3
1
4
1
1
5
2
3
1
1
3
6
1
1
4
1
1
4
3
1
1
1
4
2
1
4
3
1
1
1
4
1
2
1
1
4
2
4
1
3
1
2
1
3
1
2
2];
Num_queue_M=[5
3
6
3
8
9
4
7
11
9
12
13
11
10
9
16
8
4
4
3
5
4
4
5
4
5
8
7
6
5
4
3
1
2
3
4
3
4
4
3
0
3
2
2
1
3
2
3
2
3
2
2
3
3
1
0
];
I_A_T_M	=[];
S_begins_M	=[];
S_ends_M	=[];
S_times_M	=[];
Num_Reneges_M=[0
1
0
2
1
2
0
0
0
0
2
0
1
0
1
0
2
0
0
1
2
0
0
0
2
0
0
1
0
1
0
1
0
0
0
5
0
0
0
0
0
1
1
0
1
0
1
1
0
0
1
0
1
0
1
5]	;
Num_V_Reneges_M=[0
0
2
0
0
0
0
1
0
2
0
0
0
0
1
3
0
0
0
0
0
1
0
0
0
0
0
0
0
2
0
0
0
1
0
1
0
0
0
0
0
2
0
0
0
1
1
0
1
0
3
0
1
0
1
0]	;
Num_C_go_vacation_D_M=[9
2
5
1
2
0
0
0
0
1
0
0
0
2
4
3
1
4
2
1
1
1
1
1
1
2
2
2
2
2
2
0
0
1
0
0
0
0
2
0
0
0
2
1
1
1
1
1
1
1
1
1
4
4
1
2];

Num_served_M=Num_arrivals_M-Num_Reneges_M-Num_V_Reneges_M;
lambda_per_hour_M=sum(Num_arrivals_M)/8;
mu_per_hour_M=sum(Num_served_M)/8;
alpha_per_hour_M=sum(Num_Reneges_M)/8;
xi_per_hour_M=sum(Num_V_Reneges_M)/8;
D_M=sum(Num_C_go_vacation_D_M )/8;
L_q_per_hour_M=sum(Num_queue_M)/8;
N_M=sum(Num_arrivals_M);
for n=0:N_M
    b=(N_M-n)/N_M;
end
Num_join_M=b;

week1=17;
week2=18;
lead_time=1/mean(week1,week2);

fprintf('Average parameter Values @ET_AM_M\n');

fprintf('N_capacity_M =');   
fprintf('%0.6f \n',N_M);

fprintf('lambda_per_hour_M =');   
fprintf('%0.6f \n',lambda_per_hour_M);

fprintf('mu_per_hour_M =');   
fprintf('%0.6f \n',mu_per_hour_M);

fprintf('lead_time =');   
fprintf('%0.6f \n',lead_time);

fprintf('alpha_per_hour_M =');   
fprintf('%0.6f \n',alpha_per_hour_M);

fprintf('xi_per_hour_M =');  
fprintf('%0.6f \n',xi_per_hour_M);

fprintf('Num_join_M =');  
fprintf('%0.6f \n',Num_join_M);

fprintf('Num_C_go_vacation_D_M =');  
fprintf('%0.6f \n',D_M);

fprintf('L_q_per_hour_M =');   
fprintf('%0.6f \n',L_q_per_hour_M);

fprintf('L_s_per_hour_M =');  
fprintf('%0.6f \n',L_q_per_hour_M+(C-D_M));
%display([N_M,lambda_per_hour,mu_per_hour,alpha_per_hour,xi_per_hour,Num_join,D]);
