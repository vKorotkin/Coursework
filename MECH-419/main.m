a = 1.5119; b = 0; eps = 0.1;

tspan = [0 100];
y0 = [a;0];
[t,y] = ode45(@(t,y) VDP_stdform(t,y), tspan, y0);

figure
plot(t,y,'-')
legend('x', 'dx/dt')
xlabel('time')
ylabel('variable')
title('Van Der Pol, numerical solution wrt time')


%% Perturbation solution
figure
t_pert = 0:0.1:100;
x_pert = arrayfun(@(t) VDP_pertSoln(t,a,b,eps), t_pert);
x_pertdot = arrayfun(@(t) VDP_pertSolndot(t,a,b,eps), t_pert);
plot(t_pert, x_pert, '-')
hold on
plot(t_pert, x_pertdot, '-')
legend('x', 'dx/dt')
xlabel('time')
ylabel('variable')
title('Van Der Pol, perturbation solution wrt time')


%% Phase planes 
figure 
plot(y(:, 1), y(:, 2));
hold on
plot(x_pert, x_pertdot, '-')
legend('Numerical solution','Perturbation - straightforward expansion')
xlabel('x')
ylabel('dx/dt')
title('Phase plane')


