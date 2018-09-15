close all;clear all;clc

%% SIMULATION OF N MOLECULES IN A M by M BOX IN TWO DIMENSIONAL PLANE
% Need: 
%   -Nested conditions for checking collision - check hard sphere dynamics
%   -Velocity transfer
%   -Maxwell distribution for sim init
%All units here are relative to each other. 
%PARAMETERS

%DEBUGGING SET
n_molec=4; %amount of molecules spaced out inside box
d=0.5; %molecule diameter
m=1; %molecule mass
spc=1; %spacing
box_dim=3; %box dimension. 

%PRODUCTION SET
% n_molec=400;
% d=0.1;
% m=1;
% spc=1;
% box_dim=22;

%% INITIALIZATION 
%Initialize all molecules with random velocities.
molec_per_row=floor(box_dim/spc)-1;

vel=zeros(2,1); %two velocity components each molecule
pos=zeros(2,1);

k=0;
for i=1:molec_per_row
    for j=1:molec_per_row
        k=k+1;
        
        pos(1, k)=i*spc; pos(2, k)=j*spc;
        
        v=2*rand(2,1)-1; %Get a random unit vector for velocity
        v = bsxfun(@rdivide,v,sqrt(sum(v.^2,1)));
        vel(:, k)=v;
        if k>=n_molec
            break;
        end
        
    end
    
    if k>=n_molec
        break;
    end
end


%% PSEUDO CODE AS IN PROJECT INSTRUCTION, ADJUSTED FOR HAILE's TEXT DERIVATION
num_iter=10;

fig_idx=1;
figure(fig_idx)
h=scatter(pos(1,:), pos(2,:)); xlim([0,box_dim]); ylim([0,box_dim]); 
tic
for i=1:num_iter

    [coll_db, wall_coll_db] = get_collisions(pos, vel, d, box_dim);
    plot_positions(pos, fig_idx, box_dim, d, [])
    [pos, vel,updated_idx] = solve_collision_and_update(coll_db, wall_coll_db, pos, vel);
    plot_positions(pos, fig_idx, box_dim, d, updated_idx)
    pause(1)

    disp(i)
end
time_taken=toc















