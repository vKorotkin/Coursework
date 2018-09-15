function [val] = solveForIntegrConstants(paramVec)
%With our Van Der Pol perturbation for, solve for a and b
a=paramVec(1); b = paramVec(2); eps = 0.1;
f1 = (cos(b)-1)*a - eps/32*a^3*sin(3*b);
f2 = -a*sin(b)+eps*( ...
    1/2*a*(1-a^2/4)*cos(b)-3/32*a^3*cos(3*b) ...
    );
val = [f1;f2];
end

