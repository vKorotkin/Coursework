function [udot] = VDP_pertSolndot(t,a,b,eps)
%Perturbation solution to first order to van der pol EQ 


u_0dot = -a*sin(t+b);
u_1dot = -a/2*(1-a^2/4)*t*sin(t+b) - 3*a^3/32*cos(3*t+3*b);

udot = u_0dot+eps*u_1dot;

    
    


end

