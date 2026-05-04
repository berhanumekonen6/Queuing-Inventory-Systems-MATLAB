%Recorded Data@Saterday
C=13;
A_Times_S	=[];
Num_arrivals_S=[3
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
Num_queue_S=[0
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
I_A_T_S	=[];
S_begins_S	=[];
S_ends_S	=[];
S_times_S	=[];
Num_Reneges_S=[0
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
Num_V_Reneges_S=[0
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
Num_C_go_vacation_D_S=[9
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
Num_served_S=Num_arrivals_S-Num_Reneges_S-Num_V_Reneges_S;
lambda_per_hour_S=sum(Num_arrivals_S)/8;
mu_per_hour_S=sum(Num_served_S)/8;
alpha_per_hour_S=sum(Num_Reneges_S)/8;
xi_per_hour_S=sum(Num_V_Reneges_S)/8;
D_S=sum(Num_C_go_vacation_D_S )/8;
L_q_per_hour_S=sum(Num_queue_S)/8;
N_S=sum(Num_arrivals_S);
for n=0:N_S
    b=(N_S-n)/N_S;
end
Num_join_S=b;

week1=17;
week2=18;
lead_time=1/mean(week1,week2);

fprintf('Average parameter Values @ET_AM_S\n');

fprintf('N_capacity_S =');   
fprintf('%0.6f \n',N_S);

fprintf('lambda_per_hour_S =');   
fprintf('%0.6f \n',lambda_per_hour_S);

fprintf('mu_per_hour_S =');   
fprintf('%0.6f \n',mu_per_hour_S);

fprintf('lead_time =');   
fprintf('%0.6f \n',lead_time);

fprintf('alpha_per_hour_S =');   
fprintf('%0.6f \n',alpha_per_hour_S);

fprintf('xi_per_hour_S =');  
fprintf('%0.6f \n',xi_per_hour_S);

fprintf('Num_join_S =');  
fprintf('%0.6f \n',Num_join_S);

fprintf('Num_C_go_vacation_D_S =');  
fprintf('%0.6f \n',D_S);

fprintf('L_q_per_hour_S =');   
fprintf('%0.6f \n',L_q_per_hour_S);

fprintf('L_s_per_hour_S =');  
fprintf('%0.6f \n',L_q_per_hour_S+(C-D_S));
%display([N_M,lambda_per_hour,mu_per_hour,alpha_per_hour,xi_per_hour,Num_join,D]);
