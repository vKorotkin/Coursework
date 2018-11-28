%% MECH 513-Control Systems
% Assignment 4 - Question 4. 
% Checking pole placement
% Vassili Korotkine 12/11/2018

A=[0 1
   -6 0]; 
C=[1 0];

L=place(A', C', [-40,-50])