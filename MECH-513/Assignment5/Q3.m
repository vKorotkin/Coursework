%% MECH 513-Control Systems
% Assignment 5 - Question 3. 
% Observer design etc
% Vassili Korotkine 27/11/2018

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

%a)
K=place(A,B,[-2+3j,-2-3j, -10,-12]);

%b)
C=[1 0 0 0
    0 1 0 0];
obsvMatRank=rank(obsv(A,C))
%rank is 4, full rank, sys OBSV. 

%c)
L=(place(A',C',4*[-2+3j,-2-3j, -10,-12]))'

%d)
Alc=[A -B*K;
     L*C  A-B*K-L*C]

%can easily see eigs of Alc are union of eigs of A-BK, A-LC
eig(Alc)

eig(A-B*K)
eig(A-L*C)

%e) One positive eigenvalue, rest negative. Therefore have unstable mode?? Check Shatil 
eig(A-B*K-L*C)

%f)


