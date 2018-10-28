%% MECH 513-Control Systems
% Assignment 3 - Part 1, Question 1, NE 5.1b from Williams and Lawrence. 
% Vassili Korotkine 20/10/2018
% Checking answer
A=[0 1 0 
   0 0 1 
   -15 -17 -7];

B = [0 0 1]';
C = [5 4 1]; D = 0;

mySys=ss(A,B,C,D);
[num,den]=tfdata(mySys);
num{1}
den{1} 

mySys=minreal(mySys);
[num,den]=tfdata(mySys);
num{1};
den{1};
[a,b,c,d]=ssdata(mySys)
[num,den]=tfdata(mySys);
num{1}
den{1}

A=-3; B=1; C=1; 
mySys=ss(A,B,C,D);
[num,den]=tfdata(mySys);
num{1};
den{1};