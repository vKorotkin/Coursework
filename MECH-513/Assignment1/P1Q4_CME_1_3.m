%% MECH 513-Control Systems
% Assignment 1 - Part 1, Question 4, CME 1.3 from Williams and Lawrence. 
% Vassili Korotkine 15/09/2018

A=[0 1 0 0
   0 0 1 0
   0 0 0 1
   -962 -126 -67 -4];
B = [0 0 0 1]';
C = [300 0 0 0]; D = 0;

mySys=ss(A,B,C,D);
[num,den]=tfdata(mySys);
num{1}
den{1} 