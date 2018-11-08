%% MECH 513-Control Systems
% Assignment 1 - Part 1, Question 7, NE 2.5 from Williams and Lawrence. 
% Vassili Korotkine 16/09/2018

close all;clear all;clc
A=[0,1;-8,-6]; B=[0;1];
C=eye(2); D=zeros(1,1);

mySys=ss(A,B,C,D);

figure(1)
step(mySys,10)

%Check against analytical
myT=linspace(0,10,100);
x1_an=arrayfun(@(t) 1/8*1-1/4*exp(-2*t)+1/8*exp(-4*t),myT);
x2_an=arrayfun(@(t) 0.5*exp(-2*t)-0.5*exp(-4*t), myT);

figure(2)
subplot(2,1,1)
plot(myT, x1_an)
ylabel('X_1')
title('Step response analytical')
subplot(2,1,2)
plot(myT, x2_an)
ylabel('X_2')
xlabel('Time (seconds)')



%%
clear all
A=[2,0;-1,1]; B=[1;-1];
C=[1,1]; D=zeros(1,1);

mySys=ss(A,B,C,D);

ctrb(mySys)