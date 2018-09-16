%% MECH 513-Control Systems
% Assignment 1 - Part 1, Question 9, CME 2.3 from Williams and Lawrence. 
% Vassili Korotkine 16/09/2018

close all;clear all;clc

A=[0 1 0 0
   0 0 1 0
   0 0 0 1
   -962 -126 -67 -4];
B = [0 0 0 1]';
C = [300 0 0 0]; D = 0;

mySys=ss(A,B,C,D);

%a)
figure(1)
impulse(mySys)
%b)
figure(2)
step(mySys)
%c)
figure(3)
x_0=[4,3,2,1]';
initial(mySys, x_0); %separate calc of response to ic's and step
%d)
csys=canon(mySys, 'modal')
% [ys,ts,xs]=step(mySys);
% y_tot=yi+ys; %superposition
% 
% figure(2)
% plot(ti, y_tot)
