%% MECH 513-Control Systems
% Assignment 4 - Question 3. 
% Checking eigenvalue placement for stabilizable system
% Vassili Korotkine 12/11/2018

close all;clear all;clc

A=[-1 1 0
    0 -2 0
    -1 0 0];
B=[0 1 0]';

A=[0, -2
   1, 0]
B=[1 0]'

% A=[2 2 01
%     -2 -1 1
%     2 0 -2]
% B=[-1 1 -1]'
% K=[4 9 0]
% [v, lam]=eig(A-B*K)

%% Place some poles

des_poles= [-2,-3];
K=place(A,B,des_poles);
[v,l]=eig(A-B*K);

T=[-1 1 0
    1 0 0
    -1 0 1];

A=[2 2 -1
    -2 -1 1
    2 0 -2]

K=[K 0]*inv(T)
B=[-1 1 -1]'
A-B*K
[v, lam]=eig(A-B*K)


    

