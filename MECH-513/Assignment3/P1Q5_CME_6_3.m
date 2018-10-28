%% MECH 513-Control Systems
% Assignment 3 - Part 1, Question 5, CME 6.3 from Williams and Lawrence. 
% Vassili Korotkine 20/10/2018

close all;clear all; clc
t=linspace(0,20,100);
A=[0 1 0 0
   0 0 1 0
   0 0 0 1
   -962 -126 -67 -4];
B = [0 0 0 1]';
C = [300 0 0 0]; D = 0;

%EIGENVALUE ANALYSIS
disp('Eigenvalues of A are:')
eig(A) %all real parts of eiganvalues strictly less than zero. sys asymptotically stable

%LYAPUNOV ANALYSIS
X=lyap(A, eye(4));
disp('Eigenvalues of X=lyap(A,eye(4)) are:')
eig(X) %eigenvalues positive => X positive definite, system stable. 

%PHASE PLOTS
figure(1)
mySys=ss(A,B,C,D);
x0=[1 0 0 0]';
[y,t,x] = initial(mySys,x0,t);
figure(1)
subplot(3,1,1)
plot(x(:,1), x(:,2)); hold on
plot(x(:,3), x(:,4))
legend('x1 v x2', 'x3 v x4')
title('Initial condition response')

%system tends to zero with time, not clear on phase plot - show w.r.t.
%time
figure(2)
for i=1:4
    plot(t,x(:,i)); hold on; 
end
title('IC response w.r.t. time');
legend('x1','x2','x3','x4')

figure(1)
subplot(3,1,2)
[y,t,x] = step(mySys,t);
plot(x(:,1), x(:,2)); hold on
plot(x(:,3), x(:,4))
legend('x1 v x2', 'x3 v x4')
title('Unit step response')

subplot(3,1,3)
[y,t,x] = impulse(mySys,t);
plot(x(:,1), x(:,2)); hold on
plot(x(:,3), x(:,4))
legend('x1 v x2', 'x3 v x4')
title('Impulse response')

