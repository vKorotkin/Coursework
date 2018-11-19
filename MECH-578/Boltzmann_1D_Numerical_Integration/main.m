%% MECH 578 Project Part 2
% Numerically integrate Boltzmann equation for 1D gas as per 
% Boltzmann equations for a binary one-dimensional ideal gas
% Nov. 19 2018 - file transferred to group project repo. This file not updated since. 
close all;clear all;clc

%% Initialize
%Variables

N=10; %num particles 
L=1; %length of wire 
ma=1; %mass a
mb=2; % mass b

delta_t=0.01; %time step size 
n_tsteps=100; %amount time steps to run for 
delta_v=0.2; % velocity step size
v_bound=5; %define velocity bound (symmetric)
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

for i = 1:Nv
    if abs(v(i))>1
        pA(i)=0;
        pB(i)=0;
    end
end

pA=pA/(delta_v*sum(pA));
pB=pB/(delta_v*sum(pB));


n_steps=100;
for t_idx=1:n_tsteps
    %% Plot
    title(sprintf('iter %d', t_idx))
    subplot(2,2,1)
    bar(v,pA)
    xlabel('v'); 
    ylabel('pA');
    subplot(2,2,2)
    bar(v, pB)
    xlabel('v'); 
    ylabel('pB'); 
    
    delta_pA=zeros(1,Nv);
    for i=1:Nv
        %disp(i)
        %summing loop, compute RHS integral for single value of v_i. 
        temp=0;
        for j=1:(Nv)
            w_a=((ma-mb)*v(i)+2*mb*v(j))/(ma+mb);  %majorly illegal, to be checked
            w_b=((mb-ma)*v(j)+2*ma*v(i))/(ma+mb);
            
            if abs(w_a)>v_bound
                w_a=w_a/abs(w_a)*v_bound;
            end
            
            if abs(w_b)>v_bound
                w_b=w_b/abs(w_b)*v_bound;
            end
            
            
            
            temp=temp+ ...
                abs(v(i)-v(j))* ...
                (interp1(v',pA',w_a,'linear')*interp1(v',pB',w_b,'linear') - ...
                interp1(v',pA',v(i),'linear')*interp1(v',pB',v(j),'linear'));
            if isnan(delta_pA(i))
                print('abtin has shitty jokes')
            end
            
        end 
        delta_pA(i)=temp;
    end
    delta_pA=delta_pA*delta_v*delta_t*N/L;
    
    delta_pB=zeros(1,Nv);
    for i=1:Nv
        temp=0;
        for j=1:(Nv)
            w_a=((ma-mb)*v(j)+2*mb*v(i))/(ma+mb);
            w_b=((mb-ma)*v(i)+2*ma*v(j))/(ma+mb);
            
            
            % due to round off error 
            if abs(w_a)>v_bound
                w_a=w_a/abs(w_a)*v_bound;
            end
            
            if abs(w_b)>v_bound
                w_b=w_b/abs(w_b)*v_bound;
            end
            
            temp=temp+ ...
                abs(v(i)-v(j))* ...
                (interp1(v',pA',w_a, 'linear')*interp1(v',pB',w_b, 'linear') - ...
                interp1(v',pA',v(j), 'linear')*interp1(v',pB',v(i), 'linear'));
        end 
        delta_pB(i)=temp;
    end
    delta_pB=delta_pB*delta_v*delta_t*N/L;
    
    pA=pA+delta_pA;
    pB=pB+delta_pB;
    
    
    subplot(2,2,3)
    bar(v, delta_pA)
    xlabel('v'); 
    ylabel('delta_pA'); 
    
    subplot(2,2,4)
    bar(v, delta_pB)
    xlabel('v'); 
    ylabel('delta_pB'); 
    
       
    
    pause(0.001);
        
end
    
    
    


















