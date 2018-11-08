%% MECH 578 Project Part 2
% Numerically integrate Boltzmann equation for 1D gas as per 
% Boltzmann equations for a binary one-dimensional ideal gas

close all;clear all;clc

%% Initialize
%Variables

N=10; %num particles 
L=1; %length of wire 
ma=1;
mb=2;

delta_t=0.1; %time step size 
n_tsteps=5; %amount time steps to run for 
delta_v=0.2; % velocity step size
v_bound=2; %define velocity bound (symmetric)
Nv=2*v_bound/delta_v+1; %size of velocity vec
v=linspace(-v_bound, v_bound, Nv);

pA=zeros(1,Nv);
pB=zeros(1, Nv);
%Initial condition
pA(floor(Nv/4))=0.5/delta_v;
pB(floor(Nv/4))=0.5/delta_v;
pA(floor(Nv*3/4))=0.5/delta_v;
pB(floor(Nv*3/4))=0.5/delta_v;

pA=rand(1,Nv);
pB=rand(1,Nv);


for t_idx=1:n_tsteps
    %% Plot
    subplot(1,2,1)
    bar(v,pA)
    xlabel('v'); 
    ylabel('pA');
    subplot(1,2,2)
    bar(v, pB)
    xlabel('v'); 
    ylabel('pA'); 
    
    for i=1:Nv
        delta_pA=zeros(1,Nv);
        for j=1:Nv
            w_a=((ma-mb)*v(i)+2*mb*v(j))/(ma+mb);
            w_b=((mb-ma)*v(j)+2*ma*v(i))/(ma+mb);
            
            delta_pA(i)=delta_pA(i)+ ...
                abs(v(i)-v(j))* ...
                (interp1q(v',pA',w_a)*interp1q(v',pB',w_b) - ...
                interp1q(v',pA',v(i))*interp1q(v',pB',v(j)));
        end 
        delta_pA=delta_pA*delta_v*N/L;
    end
    
    for i=1:Nv
        delta_pB=zeros(1,Nv);
        for j=1:Nv
            w_a=((ma-mb)*v(j)+2*mb*v(i))/(ma+mb);
            w_b=((mb-ma)*v(i)+2*ma*v(j))/(ma+mb);
            
            delta_pA(i)=delta_pA(i)+ ...
                abs(v(i)-v(j))* ...
                (interp1q(v',pA',w_a)*interp1q(v',pB',w_b) - ...
                interp1q(v',pA',v(j))*interp1q(v',pB',v(i)));
        end 
        delta_pA=delta_pA*delta_v*N/L;
    end

    
    pA=pA+delta_pA;
    pB=pB+delta_pB;
    
    
    
       
    
    pause(0.5);
        
end
    
    
    


















