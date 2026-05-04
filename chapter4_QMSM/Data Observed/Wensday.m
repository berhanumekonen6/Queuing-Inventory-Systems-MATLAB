%Recorded Data@Wensday
C=13;
A_Times_W	=[];
Num_arrivals_W=[3
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
Num_queue_W=[0
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
I_A_T_W	=[];
S_begins_W	=[];
S_ends_W	=[];
S_times_W	=[];
Num_Reneges_W=[0
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
Num_V_Reneges_W=[0
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
Num_C_go_vacation_D_W=[9
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

Num_served_W=Num_arrivals_W-Num_Reneges_W-Num_V_Reneges_W;
lambda_per_hour_W=sum(Num_arrivals_W)/8;
mu_per_hour_W=sum(Num_served_W)/8;
alpha_per_hour_W=sum(Num_Reneges_W)/8;
xi_per_hour_W=sum(Num_V_Reneges_W)/8;
D_W=sum(Num_C_go_vacation_D_W )/8;
L_q_per_hour_W=sum(Num_queue_W)/8;
N_W=sum(Num_arrivals_W);
for n=0:N_W
    b=(N_W-n)/N_W;
end
Num_join_W=b;

week1=17;
week2=18;
lead_time=1/mean(week1,week2);

fprintf('Average parameter Values @ET_AM_W\n');

fprintf('N_capacity_W =');   
fprintf('%0.6f \n',N_W);

fprintf('lambda_per_hour_W =');   
fprintf('%0.6f \n',lambda_per_hour_W);

fprintf('mu_per_hour_W =');   
fprintf('%0.6f \n',mu_per_hour_W);

fprintf('lead_time =');   
fprintf('%0.6f \n',lead_time);

fprintf('alpha_per_hour_W =');   
fprintf('%0.6f \n',alpha_per_hour_W);

fprintf('xi_per_hour_W =');  
fprintf('%0.6f \n',xi_per_hour_W);

fprintf('Num_join_W =');  
fprintf('%0.6f \n',Num_join_W);

fprintf('Num_C_go_vacation_D_W =');  
fprintf('%0.6f \n',D_W);

fprintf('L_q_per_hour_W =');   
fprintf('%0.6f \n',L_q_per_hour_W);

fprintf('L_s_per_hour_W =');  
fprintf('%0.6f \n',L_q_per_hour_W+(C-D_W));
%display([N_M,lambda_per_hour,mu_per_hour,alpha_per_hour,xi_per_hour,Num_join,D]);
