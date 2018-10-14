%% MECH 513-Control Systems
% Assignment 2 - Part 2, Question 8c. 
% Controllability of linearized system
% Vassili Korotkine 13/10/2018


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

mySys=ss(A,B,[0 0 0 1],0);

ctrb(mySys)
rank(ctrb(mySys))





