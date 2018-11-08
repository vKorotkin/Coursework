%% MECH 513-Control Systems
% Assignment 3 - Part 2, Question 8. 
% Controlling linearized system
% Vassili Korotkine 28/10/2018

close all;clear all;clc
%% Copypaste from last assignment for computing A, B
%Parameter values from assignment



mp = 0.127; % kg, mass.
Lp = 0.33655; % m
mr = 0.257; % kg, mass.
Lr = 0.2159; % m
g = 9.81; % m/sˆ2
Dr = 0.0024; % N m s / rad
Dp = 0.0024; % N m s / rad
kt = 0.00768; % N m / A
km = kt; % V / ( rad / s)
eta_m = 0.69;
eta_g = 0.9;
Kg = 70;
Rm = 2.6; % Ohms


%Derived analytically in part a)
a=Kg*eta_g*eta_m*kt/Rm;
b=Kg*km;

Mbar=[mp*Lr^2+mr*Lr^2/3, -1*Lr*Lp*mp/2;
      -1*Lr*Lp*mp/2, mp*Lp^2/3];
Dv_prime=diag([Dr+a*b, Dp]);
b_prime=[a;0];

A=[zeros(2,2), eye(2);
   zeros(2,1), Mbar\[0; g*Lp*mp/2], -Mbar\Dv_prime];
B=[zeros(2,1);
   Mbar\b_prime];

%% Place some poles

des_poles= [-6+0.25j, -6-0.25j,-7,-8];
K=place(A,B,des_poles)

%% Simulate nonlinsys

x0=[0, -10/180*pi, 0, 0]'; %initial condition
t_f=3;
%Tolerance values - copy paste from assignment instruction. 
options = odeset('AbsTol',1e-10,'RelTol',1e-10);

%Solve system, plot system
t=linspace(0,t_f,100);

M=@(a)[mp*Lr^2+mr*Lr^2/3, -cos(a)*Lr*Lp*mp/2
   -cos(a)*Lr*Lp*mp/2, mp*Lp^2/3];
Fnl=@(a,a_dot)[sin(a)*Lr*Lp*mp*a_dot^2/2; -sin(a)*g*Lp*mp/2];
b_pr=b_prime;
V=@(x) -K*x;
Dv_pr=diag([Dr+Kg^2*eta_g*eta_m*kt*km/Rm, Dp]);


%fn to integrate
%x contains [q, q_dot]' where q=[th, a] => x=[th,a,th_dot,a_dot]'
f=@(t,x)[x(3);
       x(4);
       M(x(2))\ ...
       (b_pr*V(x)-Fnl(x(2),x(4))-Dv_pr*[x(3);x(4)])];

[t,x]=ode45(f, t, x0, options);


%% GET INTERESTING QUANTITIES
a_oversh=max(x(:,2))/pi*180;

%% PLOTS
figure(1)
subplot(2,1,1)
for i=[2,4]
    plot(t,x(:,i)/pi*180); hold on
end
legend('a','a dot')
title(sprintf('System states vs time, a oversh is %.2f deg', a_oversh))
ylabel('state')

subplot(2,1,2)
V=-K*x';
max_V=max(V);
plot(t,V)
title(sprintf('Voltage v time; max V: %.2f', max(V)))
xlabel('time'); ylabel('Voltage')



    

