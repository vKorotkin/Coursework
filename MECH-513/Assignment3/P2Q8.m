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
   zeros(2,1), Mbar\[0; g*Lp*mp/2], -Mbar\Dv_prime]
B=[zeros(2,1);
   Mbar\b_prime]
C=eye(4); D=0; 







%% Place some poles
x0=[0, -10/180*pi, 0, 0]';
t_f=1;
des_poles= [-2+10j, -2-10j,-7,-8];
des_poles= [-2+10j, -2-10j,-7,-8];
K=place(A,B,des_poles);
sys=ss(A-K*B,B,C,D);
[y,t,x] = initial(sys,x0,t_f);

figure(1)
subplot(2,1,1)
for i=1:4
    plot(t,x(:,i)); hold on
end
legend('th','a','th_dot','a_dot')
ylabel('state')
title('States')

in_V=-K*x';
subplot(2,1,2)
plot(t, in_V);
title('Voltage')
xlabel('t'); ylabel('V')


