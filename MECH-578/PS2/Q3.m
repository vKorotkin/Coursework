%Do integration for Q3 for Cv. 
clear all;close all;clc
global thDeb;
global thEin;
global Tlbound;
global Tubound;
global h;
global k;
global c;

thDeb=343.5;
thEin=265;
Tlbound=2;
Tubound=100;
h=6.62607004e-34; %planck
k=1.38064852e-23; %boltz
c=4600; %speed of sound in copper

nT=200;
T=linspace(Tlbound, Tubound, nT);
Cv=zeros(1,nT);
%i=100;
%cv_integrand(2,3)
%myRiemann(@(th) cv_integrand(th, T(i)), 0, thDeb,200)

for i=1:nT
    Cv(i)=myRiemann(@(th) cv_integrand(th, T(i)), 0, thDeb, 1000);
end

plot(T, Cv)
xlabel('Temperature');
ylabel('Cv');
title('Cv as function of temperature, Debye')
    




function integr=myRiemann(f, a,b, n)
dx=(b-a)/n;

domain=linspace(a,b,n);
integr=sum(arrayfun(f, domain(2:n)))*dx;


end

function y = cv_integrand(th, T)
global h;
global k;
global c;
% Return the value of the integrand in Cv, from theta (variable integrated
% over) and T (independent var against which we plot. 
% As is in the in the Cv
% expression in PS2. 
% The formula is computed in mathematica. Note that for the integration, we 
% also change the df to dth, dth=h/kdf
% y= 12*k^3*pi*th^2/(c^3*h^2) ...
%     *(exp(-2*th/T)*th^2+exp(-th/T)*th^2)/...
%     ((1-exp(-th/T))^2*T^2);

y= 12*k^3*pi*th.^2/(c^3*h^2) ...
    *(exp(-2*th/T)*th.^2+exp(-th/T)*th.^2)/...
    ((1-exp(-th/T))^2*T^2);
        

end
