%Recorded Data@Tuesday
C=13;
A_Times_Tu	=[];
Num_arrivals_Tu=[1
2
1
1
4
1
1
5
1
1
1
1
1
3
1
1
2
1
1
1
1
1
1
1
1
2
2
1
1
1
1
1
3
1
2
2
2
3
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
2
1
1
1
3
1
];
Num_queue_Tu=[0
2
2
7
11
14
16
12
8
6
12
6
4
2
2
2
2
2
2
4
5
18
4
3
3
5
6
1
1
1
1
4
4
3
5
7
11
5
2
3
2
1
1
1
1
1
2
5
4
4
6
6
5
4
1
1
];
I_A_T_Tu	=[];
S_begins_Tu	=[];
S_ends_Tu	=[];
S_times_Tu	=[];
Num_Reneges_Tu=[0
1
0
0
0
2
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
1
0
0
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
1
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
1
1
0
0
0
0
0
]	;
Num_V_Reneges_Tu=[0
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
]	;
Num_C_go_vacation_D_Tu=[0
0
0
3
3
3
3
4
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
1
1
2
2
0
0
0
0
0
0
3
3
3
3
3
3
3
2
2
2
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
2
];

Num_served_Tu=Num_arrivals_Tu-Num_Reneges_Tu-Num_V_Reneges_Tu;
lambda_per_hour_Tu=sum(Num_arrivals_Tu)/8;
mu_per_hour_Tu=sum(Num_served_Tu)/8;
alpha_per_hour_Tu=sum(Num_Reneges_Tu)/8;
xi_per_hour_Tu=sum(Num_V_Reneges_Tu)/8;
D_Tu=sum(Num_C_go_vacation_D_Tu )/8;
L_q_per_hour_Tu=sum(Num_queue_Tu)/8;
N_Tu=sum(Num_arrivals_Tu);
for n=0:N_Tu
    b=(N_Tu-n)/N_Tu;
end
Num_join_Tu=b;

week1=17;
week2=18;
lead_time=1/mean(week1,week2);

fprintf('Average parameter Values @ET_AM_Tu\n');

fprintf('N_capacity_Tu =');   
fprintf('%0.6f \n',N_Tu);

fprintf('lambda_per_hour_Tu =');   
fprintf('%0.6f \n',lambda_per_hour_Tu);

fprintf('mu_per_hour_Tu =');   
fprintf('%0.6f \n',mu_per_hour_Tu);

fprintf('lead_time =');   
fprintf('%0.6f \n',lead_time);

fprintf('alpha_per_hour_Tu =');   
fprintf('%0.6f \n',alpha_per_hour_Tu);

fprintf('xi_per_hour_Tu =');  
fprintf('%0.6f \n',xi_per_hour_Tu);

fprintf('Num_join_Tu =');  
fprintf('%0.6f \n',Num_join_Tu);

fprintf('Num_C_go_vacation_D_Tu =');  
fprintf('%0.6f \n',D_Tu);

fprintf('L_q_per_hour_Tu =');   
fprintf('%0.6f \n',L_q_per_hour_Tu);

fprintf('L_s_per_hour_Tu =');  
fprintf('%0.6f \n',L_q_per_hour_Tu+(C-D_Tu));
%display([N_M,lambda_per_hour,mu_per_hour,alpha_per_hour,xi_per_hour,Num_join,D]);
