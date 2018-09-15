function [y_dot] = VDP_stdform(t, y)
%Standard form of Van Der Pol ODE
    %x'' +eps*(x^2-1)*x' + x - 0; put [x;xdot] = y;
eps = 0.1;
x = y(1); v = y(2);

y_dot = [v; ...
         -x-eps*(x^2-1)*v
        ];
end

