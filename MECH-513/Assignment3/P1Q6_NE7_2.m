%% MECH 513-Control Systems
% Assignment 3 - Part 1, Question 6, NE 7.2 from Williams and Lawrence. 
% Vassili Korotkine 28/10/2018


A=[0 1;
   -6, 0];
B = [0 1]';
C=[1,0];
D=0;
mySys=ss(A,B,C,D);

K = place(A,B,[-4,-5])


%C = [5 4 1]; D = 0;