%% MECH 578 Project Part 2
% Numerically integrate Boltzmann equation for 1D gas as per 
% Boltzmann equations for a binary one-dimensional ideal gas

close all;clear all;clc

%% Initialize
%Variables

N=10; %num particles 
L=1; %length of wire 
ma=1; %mass a
mb=2; % mass b

delta_t=0.1; %time step size 
n_tsteps=100; %amount time steps to run for 
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
        for j=1:(Nv-2)
            w_a=((ma-mb)*v(i)+2*mb*v(j))/(ma+mb);
            w_b=((mb-ma)*v(j)+2*ma*v(i))/(ma+mb);
            
            if abs(w_a)>v_bound
                w_a=w_a/abs(w_a)*v_bound;
            end
            
            if abs(w_b)>v_bound
                w_b=w_b/abs(w_b)*v_bound;
            end
            
            delta_pA(i)=delta_pA(i)+ ...
                abs(v(i)-v(j))* ...
                (interp1(v',pA',w_a,'nearest')*interp1(v',pB',w_b,'nearest') - ...
                interp1(v',pA',v(i),'nearest')*interp1(v',pB',v(j),'nearest'));
            if isnan(delta_pA(i))
                print('abtin has shitty jokes')
            end
            
        end 
        delta_pA=delta_pA*delta_v*delta_t*N/L;
    end
    
    delta_pB=zeros(1,Nv);
    for i=1:Nv
        
        for j=1:Nv
            w_a=((ma-mb)*v(j)+2*mb*v(i))/(ma+mb);
            w_b=((mb-ma)*v(i)+2*ma*v(j))/(ma+mb);
            
            
            % due to round off error 
            if abs(w_a)>v_bound
                w_a=w_a/abs(w_a)*v_bound;
            end
            
            if abs(w_b)>v_bound
                w_b=w_b/abs(w_b)*v_bound;
            end
            
            delta_pB(i)=delta_pB(i)+ ...
                abs(v(i)-v(j))* ...
                (interp1(v',pA',w_a, 'nearest')*interp1(v',pB',w_b, 'nearest') - ...
                interp1(v',pA',v(j), 'nearest')*interp1(v',pB',v(i), 'nearest'));
        end 
        delta_pB=delta_pB*delta_v*delta_t*N/L;
    end

    
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
    
       
    
    pause(0.5);
        
end
    
    
    


















