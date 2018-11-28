%% MECH 513-Control Systems
% Assignment 4 - Question 2. 
% Pole placement for integral action.
% Vassili Korotkine 1/11/2018

close all;clear all;clc

A=[-1 1 0
    0 -2 0
    -1 0 0];
B=[0 1 0]';

%% Place some poles

des_poles= [-2+1j, -2-1j,-8];
K=place(A,B,des_poles)


    

