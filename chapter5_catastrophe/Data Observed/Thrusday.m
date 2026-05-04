%Recorded Data@Thrusday
C=13;
A_Times_Thr	=[];
Num_arrivals_Thr=[3
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
Num_queue_Thr=[0
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
I_A_T_Thr	=[];
S_begins_Thr	=[];
S_ends_Thr	=[];
S_times_Thr	=[];
Num_Reneges_Thr=[0
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
Num_V_Reneges_Thr=[0
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
Num_C_go_vacation_D_Thr=[9
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
Num_served_Thr=Num_arrivals_Thr-Num_Reneges_Thr-Num_V_Reneges_Thr;
lambda_per_hour_Thr=sum(Num_arrivals_Thr)/8;
mu_per_hour_Thr=sum(Num_served_Thr)/8;
alpha_per_hour_Thr=sum(Num_Reneges_Thr)/8;
xi_per_hour_Thr=sum(Num_V_Reneges_Thr)/8;
D_Thr=sum(Num_C_go_vacation_D_Thr )/8;
L_q_per_hour_Thr=sum(Num_queue_Thr)/8;
N_Thr=sum(Num_arrivals_Thr);
for n=0:N_Thr
    b=(N_Thr-n)/N_Thr;
end
Num_join_Thr=b;

week1=17;
week2=18;
lead_time=1/mean(week1,week2);

fprintf('Average parameter Values @ET_AM_W\n');

fprintf('N_capacity_Thr =');   
fprintf('%0.6f \n',N_Thr);

fprintf('lambda_per_hour_Thr =');   
fprintf('%0.6f \n',lambda_per_hour_Thr);

fprintf('mu_per_hour_Thr =');   
fprintf('%0.6f \n',mu_per_hour_Thr);

fprintf('lead_time =');   
fprintf('%0.6f \n',lead_time);

fprintf('alpha_per_hour_Thr =');   
fprintf('%0.6f \n',alpha_per_hour_Thr);

fprintf('xi_per_hour_Thr =');  
fprintf('%0.6f \n',xi_per_hour_Thr);

fprintf('Num_join_Thr =');  
fprintf('%0.6f \n',Num_join_Thr);

fprintf('Num_C_go_vacation_D_Thr =');  
fprintf('%0.6f \n',D_Thr);

fprintf('L_q_per_hour_Thr =');   
fprintf('%0.6f \n',L_q_per_hour_Thr);

fprintf('L_s_per_hour_Thr =');  
fprintf('%0.6f \n',L_q_per_hour_Thr+(C-D_Thr));
%display([N_M,lambda_per_hour,mu_per_hour,alpha_per_hour,xi_per_hour,Num_join,D]);
