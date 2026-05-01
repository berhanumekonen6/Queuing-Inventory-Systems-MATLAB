%Expected Values from Recorded Data@Allday(2*(Monday till Saterday))
C=13;
A_Times	=A_Times_M+A_Times_Tu+A_Times_W+A_Times_Thr+A_Times_F+A_Times_S;
Num_arrivals=Num_arrivals_M+Num_arrivals_Tu+Num_arrivals_W+Num_arrivals_Thr+Num_arrivals_F+Num_arrivals_S;
Num_queue=Num_queue_M+Num_queue_Tu+Num_queue_W+Num_queue_Thr+Num_queue_F+Num_queue_S;
I_A_T_S	=I_A_T_M+I_A_T_Tu+I_A_T_W+I_A_T_Thr+I_A_T_F+I_A_T_S;
S_begins	=S_begins_M+S_begins_Tu+S_begins_W+S_begins_Thr+S_begins_F+S_begins_S;
S_ends	=S_ends_M+S_ends_Tu+S_ends_W+S_ends_Thr+S_ends_F+S_ends_S;
S_times	=S_times_M+S_times_Tu+S_times_W+S_times_Thr+S_times_F+S_times_S;
Num_Reneges= Num_Reneges_M+Num_Reneges_Tu+Num_Reneges_W+Num_Reneges_Thr+Num_Reneges_F+Num_Reneges_S	;
Num_V_Reneges=	Num_V_Reneges_M+Num_V_Reneges_Tu+Num_V_Reneges_W+Num_V_Reneges_Thr+Num_V_Reneges_F+Num_V_Reneges_S;
Num_C_go_vacation_D= Num_C_go_vacation_D_M+Num_C_go_vacation_D_Tu+Num_C_go_vacation_D_W+Num_C_go_vacation_D_Thr+Num_C_go_vacation_D_F+Num_C_go_vacation_D_S;
Num_served=Num_arrivals-Num_Reneges-Num_V_Reneges;
lambda_per_hour=(1/6)*sum(Num_arrivals)/8;
mu_per_hour=(1/6)*sum(Num_served)/8;
alpha_per_hour=(1/6)*sum(Num_Reneges)/8;
xi_per_hour=(1/6)*sum(Num_V_Reneges)/8;
D=(1/6)*sum(Num_C_go_vacation_D )/8;
L_q_per_hour=(1/6)*sum(Num_queue)/8;
N=(1/6)*sum(Num_arrivals);
for n=0:N
    b=(N-n)/N;
end
Num_join=b;

week1=17;
week2=18;
lead_time=1/mean(week1,week2);

fprintf('Average parameter Values @ET_AM_Allday\n');

fprintf('N_capacity =');   
fprintf('%0.6f \n',N);

fprintf('lambda_per_hour =');   
fprintf('%0.6f \n',lambda_per_hour);

fprintf('mu_per_hour =');   
fprintf('%0.6f \n',mu_per_hour);

fprintf('lead_time =');   
fprintf('%0.6f \n',lead_time);

fprintf('alpha_per_hour =');   
fprintf('%0.6f \n',alpha_per_hour);

fprintf('xi_per_hour =');  
fprintf('%0.6f \n',xi_per_hour);

fprintf('Num_join =');  
fprintf('%0.6f \n',Num_join);

fprintf('Num_C_go_vacation_D =');  
fprintf('%0.6f \n',D);

fprintf('L_q_per_hour =');   
fprintf('%0.6f \n',L_q_per_hour);

fprintf('L_s_per_hour =');  
fprintf('%0.6f \n',L_q_per_hour+(C-D));
%display([N_M,lambda_per_hour,mu_per_hour,alpha_per_hour,xi_per_hour,Num_join,D]);
