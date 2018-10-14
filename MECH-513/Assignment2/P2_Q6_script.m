%% MECH 513-Control Systems
% Assignment 2 - Part 2, Question 6. 
% Intro to Simulink
% Vassili Korotkine 10/10/2018

close all;clear all;clc

%Part a)
figure(3)
I = imread('SimulinkMdlP2_Q6.png');
imshow(I)


A=[0 -1; 1, -3];
[V,D]=eig(A); 


mdl_name='P2_Q6'; 
sys='P2_Q6'


load_system(mdl_name)

%Part b,c)
subplt_idx=1;
for x1_nod = [-1, 1, 3]
    for x2_nod = [-1,1,3]
    eig_nod=inv(V)*[x1_nod;x2_nod];    

    set_param([mdl_name, '/x1integ/'],'InitialCondition', 'x1_nod'); 
    set_param('P2_Q6/x2integ/','InitialCondition', 'x2_nod'); 


    sim(sys,30);
    y1out=yout{1}.Values.Data;
    y2out=yout{2}.Values.Data;


    
    figure(2)
    subplot(3,3,subplt_idx)
    plot(y1out, y2out); hold on
    plot(y1out, V(2,1)/V(1,1)*y1out); hold on
    plot(y1out, V(2,2)/V(1,2)*y1out); hold on
    if subplt_idx==1
        legend('Response', 'Eig:-0.38', 'Eig: -2.6')
    end
    
    title(sprintf('IC %.2f, %.2f', x1_nod, x2_nod)); 
    xlabel('x1'); ylabel('x2'); 
    
%     figure(3)
%     subplot(3,3,subplt_idx)
%     plot(tout, y1out); hold on; plot(tout, y2out)
%     title(sprintf('IC %.2f, %.2f', x1_nod, x2_nod)); 
%     xlabel('Time'); ylabel('x'); legend('x1', 'x2');
    
    subplt_idx=subplt_idx+1;
    end 
end

% 
