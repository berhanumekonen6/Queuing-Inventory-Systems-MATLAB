%Recorded Data@Friday
C=13;
A_Times_F	=[];
Num_arrivals_F=[3
1
1
1
1
1
3
3
1
1
1
1
1
1
3
3
3
3
1
1
1
1
1
1
1
4
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
1
1
1
1
1
1
1
1
1
3
2
2
1
1
1
1
1
3
3
3
];
Num_queue_F=[0
0
0
0
0
0
2
2
2
2
2
2
3
4
7
10
13
10
11
12
7
8
9
5
6
10
5
5
1
1
0
1
3
5
4
5
3
2
1
0
1
2
0
1
2
3
1
0
1
2
0
0
0
0
0
0
];
I_A_T_F	=[];
S_begins_F	=[];
S_ends_F	=[];
S_times_F	=[];
Num_Reneges_F=[0
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
1
1
1
2
3
2
1
1
1
0
0
0
0
0
0
0
0
0
0
0
0
0
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
0
0
0
0
0
0
0
0
1
2
]	;
Num_V_Reneges_F=[0
0
0
0
0
0
1
1
0
0
0
0
0
0
0
0
2
1
0
0
0
0
0
0
0
0
0
1
2
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
]	;
Num_C_go_vacation_D_F=[9
7
5
3
1
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
1
1
1
1
1
0
0
0
0
0
0
0
0
0
0
0
0
4
2
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
2
];
Num_served_F=Num_arrivals_F-Num_Reneges_F-Num_V_Reneges_F;
lambda_per_hour_F=sum(Num_arrivals_F)/8;
mu_per_hour_F=sum(Num_served_F)/8;
alpha_per_hour_F=sum(Num_Reneges_F)/8;
xi_per_hour_F=sum(Num_V_Reneges_F)/8;
D_F=sum(Num_C_go_vacation_D_F )/8;
L_q_per_hour_F=sum(Num_queue_F)/8;
N_F=sum(Num_arrivals_F);
for n=0:N_F
    b=(N_F-n)/N_F;
end
Num_join_F=b;

week1=17;
week2=18;
lead_time=1/mean(week1,week2);

fprintf('Average parameter Values @ET_AM_F\n');

fprintf('N_capacity_F =');   
fprintf('%0.6f \n',N_F);

fprintf('lambda_per_hour_F =');   
fprintf('%0.6f \n',lambda_per_hour_F);

fprintf('mu_per_hour_F =');   
fprintf('%0.6f \n',mu_per_hour_F);

fprintf('lead_time =');   
fprintf('%0.6f \n',lead_time);

fprintf('alpha_per_hour_F =');   
fprintf('%0.6f \n',alpha_per_hour_F);

fprintf('xi_per_hour_F =');  
fprintf('%0.6f \n',xi_per_hour_F);

fprintf('Num_join_F =');  
fprintf('%0.6f \n',Num_join_F);

fprintf('Num_C_go_vacation_D_F =');  
fprintf('%0.6f \n',D_F);

fprintf('L_q_per_hour_F =');   
fprintf('%0.6f \n',L_q_per_hour_F);

fprintf('L_s_per_hour_F =');  
fprintf('%0.6f \n',L_q_per_hour_F+(C-D_F));
%display([N_M,lambda_per_hour,mu_per_hour,alpha_per_hour,xi_per_hour,Num_join,D]);
