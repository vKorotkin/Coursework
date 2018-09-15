function [u] = VDP_pertSoln(t,a,b,eps)
%Perturbation solution to first order to van der pol EQ 

u_0 = a*cos(t+b);
u_1 = a/2*(1-a^2/4)*t*cos(t+b) - a^3/32*sin(3*t+3*b);


u = u_0+eps*u_1;



    
    


end

