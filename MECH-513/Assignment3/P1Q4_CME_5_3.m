%% MECH 513-Control Systems
% Assignment 3 - Part 1, Question 4, CME 5.3 from Williams and Lawrence. 
% Vassili Korotkine 20/10/2018

A=[0 1 0 0
   0 0 1 0
   0 0 0 1
   -962 -126 -67 -4];
B = [0 0 0 1]';
C = [300 0 0 0]; D = 0;

mySys=ss(A,B,C,D);
myMinSys=minreal(mySys); 
obsvmat=obsv(mySys)
rank(obsvmat) %=4 -> system ctrb and obsv, sys is min realzn, consistent with myMinSys
[A,B,C,D]=ssdata(myMinSys) %->system already min realzn