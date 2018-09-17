%% MECH 513-Control Systems
% Assignment 1 - Part 2, Question 11. 
% Comparing nonlinear system response with linear system linearized about
% nominal input & state. 
% Vassili Korotkine 17/09/2018

close all; clear all; clc

x_0=zeros(2,1);
t=0:0.01:10;
 %system parameters
global a_1; a_1=0.5;
global a_2; a_2=0.7;




 options = odeset('RelTol',1e-7);
[t,x]=ode45(@myNonLinSys, t, x_0, options);
y_num=x(:,1); 
y_an=arrayfun(@(t) exp(-3)/a_1*(1-exp(-a_1*t)),t); 

figure
plot(t,y_num); hold on
plot(t,y_an); 
legend('Numerical', 'Analytical, linearized about x=0, u=0')
ylabel('Output y'); xlabel('Time t');
title('Numerical solution comparison vs analytical linearization')




function  [x_dot]= myNonLinSys(t,x)

global a_1
global a_2

u=exp(-3); %define the input, which is constant
A_x=[-a_1+sin(x(2)), sin(x(2))
    sin(x(1)), -a_2+sin(x(2))];
B=[1;1];

x_dot=A_x*x+B*u;

end
