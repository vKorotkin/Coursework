%% In this problem, you will work with a ball suspended magnetically in air.
% You will go through the full process starting from taking the model of
% the system, determining its stability, solving the pole placement problem, 
% using the Input Gain to satisfy steady-state tracking specification,
% designing the observer and simulating the system with the
% observed state feedback. 
%
%% 1. Modeling
% The model of this system is given below. The current through the coils induces a 
% magnetic force which can balance the force of gravity and cause the ball 
% (which is made of a magnetic material) to be suspended in midair.  
%%
% The equations for the system are given by:
%
%%
% $$
% M\frac{d^2h}{dt^2} = Mg - \frac{Ki^2}{h}
% $$
%
%%
% $$
% V = L\frac{di}{dt} + iR
% $$
%
%%
% where |h| is the vertical position of the ball, |i| is the current 
% through the electromagnet, |V| is the applied voltage, |M| is the mass of
% the ball, |g| is gravity, |L| is the inductance, |R| is the resistance, 
% and |K| is a coefficient that determines the magnetic force exerted on 
% the ball.  For simplicity, we will choose values |M = 0.05 Kg|, 
% |K = 0.0001|, |L = 0.01 H|, |R = 1 Ohm|, |g = 9.81 m/sec^2|. The system 
% is at equilibrium (the ball is suspended in midair) whenever 
% |h = K i^2/Mg| (at which point |dh/dt = 0|).  We linearize the equations 
% about the point |h = 0.01 m| (where the nominal current is about 7 amp) 
% and get the state space equations. 
% The state variables are deviations in h, derivative of h and current i (a 3x1 vector), |u| is the
% input voltage (delta |V|), and |y| (the output), is the deviation in h.
% The system matrices for the linearized system are given below.
%%
close all; clear all;clc

A = [ 0   1   0
     980  0  -2.8
      0   0  -100 ];

B = [ 0
      0
      100 ];
  
C = [ 1 0 0 ];

%% 2. Stability
%
% One of the first things we want to do is analyze whether the open-loop
% system (without any control) is stable. Determine the stability of the
% system.
%
%%
mySys=ss(A,B,C,0);
isstable(mySys) %returns 0, not stable

%%
% Check your stability conclusion by simulating the system response to a nonzero
% initial condition (zero input). Take this state as your initial condition: 
% x0 = [0.01 0.5 -5] (and use it for the remainder of this question as needed). 
% Plot the output response to this initial condition and comment on your results.
%
%%
x0 = [0.01 0.5 -5]';
initial(mySys,x0) %plot goes to infty (exponentially), obviously unstable 


%% 3. Controllability and Observability
% Check controllability and observability of your system. Comment on your
% results. 
%
%%
P=ctrb(mySys); rank(P) %rank=3, full, for both. system controllable and observable.
Q=obsv(mySys); rank(Q)


%% 4. Control Design Using Pole Placement
% Next, build a state feedback controller for this system using pole placement.  
% Determine the gain matrix K to place the poles at the
% following locations: -20 + 20i, -20 - 20i, -100

%%
K=place(A,B,[-20 + 20i, -20 - 20i, -100])



%%
% Simulate the response of the system to an initial condition x0 = [0.01 0.5 -5] to
% demonstrate closed-loop transient performance. Plot the output response. Use the appropriate time scale. 
% What is is the  setting time of your system (approximately)? 
% Plot the control effort (voltage input) required.

%%
mySys=ss(A-B*K, B, C, 0);
[y,t,x] = initial(mySys,x0); %setting time ~0.3 seconds
volt=-K*x';
figure
plot(t,y); hold on
plot(t,zeros(1,length(t)))
xlabel('time (s)')
ylabel('output val')
title('Output response')
legend('output', 'zero line')

figure
plot(t,volt)
xlabel('time (seconds)')
ylabel('control effort (voltage)')
title('Control Effort')

%% 5. Introducing the Reference Input
% Now, you will take the control system as defined above and apply a step
% input (we choose a small value for the step, so we remain in the region 
% where our linearization is valid). Use a step input of magnitude 0.001
% and simulate the response of the system to this input. What do you
% observe?
%
%%

%system linear, response to step of magn. 0.001 is same as 0.001 of
%response to unit step. 
mySys=ss(A-B*K, B, C, 0);
[y,t,x] = step(mySys);
y=0.001*y; x=0.001*x;

plot(t,y)
title('Response of linearized sys to step input')
xlabel('time')
ylabel('output value')


%%
% Use Input Gain method to determine the gain to achieve tracking of the
% step input. Simulate the system with the same input as before and comment
% on your results.
%
%%
close all
G=-inv(C*inv(A-B*K)*B);
mySys=ss(A-B*K, B*G, C, 0);
[y,t,x] = step(mySys);
y=0.001*y; x=0.001*x;

plot(t,y)
title('Response of linearized sys to step input')
xlabel('time')
ylabel('output value')

%% 6. Observer Design
%
% Next, we will build an *observer* to estimate the states, while measuring only the output
% |y = C x|.  
% First, we need to choose the observer gain L.  Since we want the
% dynamics of the observer to be much faster than the system itself, we
% need to place the poles at least five times farther to the left than the
% dominant poles of the system. Place the observer poles at -100, -101,
% -102. 

%%
L=(place(A',C',[-100,-101,-102]))'


%%
% Define the combined equations for the system plus observer
% using the original state |x| plus the error state: |e = x - \hat{x}|. 
%
%%

%as in the notes, for input gain the error transformed sys dynamics given
%by
Astar=[A-B*K, -B*K
        zeros(3,3), A-L*C]
Bstar=[B;zeros(3,1)]
Cstar=[C, zeros(1,3)]



%% 7. Now, we will simulate the response of the closed-loop combined system 
% to  a nonzero initial condition with no reference input.  We typically assume 
% that the observer begins with zero initial condition, \hat{x} = 0. 
% Use the following initial condition for the state: x0 = [0.01 0.5 -5]
%
%%

x0 = [0.01 0.5 -5];
err0=x0; %observer is at zero->error is x0

mySys=ss(Astar, Bstar, Cstar, 0);

%%
% We would like to verify the performance of the observer. Plot each state
% with the corresponding estimated state and comment on these results. 
%
%%\

[y,t,x]=initial(mySys, [x0, err0]);
sz=size(x)

for i=1:3
figure

plot(t,x(:,i)); hold on
plot(t,x(:,i)-x(:,i+3))
title(sprintf('State %d val and estianate', i))
legend('actual', 'estimate')
xlabel('time')
ylabel('state and estimate val')
end


