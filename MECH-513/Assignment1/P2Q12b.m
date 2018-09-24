%% MECH 513-Control Systems
% Assignment 1 - Part 2, Question 12b). 
% Simulate inverted pendulum uncontrolled dynamics
% Vassili Korotkine 17/09/2018


clear all; close all; clc

%System parameters - copy paste from assignment instruction. 
global mp; mp = 0.127; % kg, mass
global Lp; Lp = 0.337; % m
global mr; mr = 0.257; % kg, mass
global Lr; Lr = 0.216; % m
global g; g = 9.81; % m/sˆ2
t_f=2; %final time
x_0=[0 -15/180*pi 0 0]'; %initial condition

%Tolerance values - copy paste from assignment instruction. 
options = odeset('AbsTol',1e-10,'RelTol',1e-10);
t=linspace(0,t_f,1000);
[t,x]=ode45(@invPendNonLinSys, t, x_0, options);
E=arrayfun(@(i) get_energy(x(i,:)), 1:length(x));
E_stddev=std(E);

figure(1)
plot(t,E)
title(sprintf('Energy vs Time, standard dev %.2e',E_stddev))
xlabel('Time'); ylabel('Energy');
ylim([0,1])
figure(2)
plot(x(:,1), x(:,3))
title('Alpha vs AlphaDot')
xlabel('Alpha,rad');ylabel('Alpha dot, rad/s')


figure(3)
plot(t, x(:,1)); hold on
plot(t, x(:,2))
xlabel('Time'); ylabel('Coord value')
legend('Theta', 'Alpha')


function x_dot=invPendNonLinSys(t,x)
% The system has four d.o.f. angles and rate of change of angles, for both angles.  
global mp; 
global Lp; 
global mr; 
global Lr; 
global g; 

th=x(1); %theta
a=x(2); %alpha
th_dot=x(3); 
a_dot=x(4); 

M=[mp*Lr^2+mr*Lr^2/3, -cos(a)*Lr*Lp*mp/2
   -cos(a)*Lr*Lp*mp/2, mp*Lp^2/3];

Fnl=[sin(a)*Lr*Lp*mp*a_dot^2/2; -sin(a)*g*Lp*mp/2];

x_dot=[th_dot
       a_dot
       -M\Fnl];

end

function E=get_energy(q)
global mp; 
global Lp; 
global mr; 
global Lr; 
global g; 

th=q(1); %theta
a=q(2); %alpha
th_dot=q(3); 
a_dot=q(4);


M=[mp*Lr^2+mr*Lr^2/3, -cos(a)*Lr*Lp*mp/2
   -cos(a)*Lr*Lp*mp/2, mp*Lp^2/3];
q_dot=[th_dot;a_dot];

E=1/2*q_dot'*M*q_dot+cos(a)*g*mp*Lp/2;


end
