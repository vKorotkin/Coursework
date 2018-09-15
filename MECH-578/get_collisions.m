function [coll_db, wall_coll_db] = get_collisions(pos, vel, d, box_dim)
% GET COLLISIONS 
% Given molecules in a box of length box_dim with specified positions, velocities, diameter,
% spacing, get times of collisions
%NOTES: Returns t_c w.r.t. 0 o.e. pos, vel are assumed at time=0. Deal with
%time incrementation outside of this fn. 
    t_0=0;
    sz=size(pos); n_molec=sz(2);
    coll_db=zeros(3,1); coll_db_idx=1;
    %coll_db: Collision database:
    %Three rows: First is particle 1 idx, second is particle 2 idx, third is
    %time of collision. 
    for i=1:(n_molec-1)
        for j=(i+1):n_molec
            rel_vel=vel(:,i)-vel(:,j);
            rel_pos=pos(:,i)-pos(:,j);
            if dot(rel_vel, rel_pos)<0 %necessary condition for condition
                %in equation for t_c in Haile, this is discriminant. Bigger
                %than zero is sufficient condition for collusion.
                discrim=(dot(rel_vel,rel_pos)^2- ...
                    norm(rel_vel)^2*(norm(rel_pos)^2-d^2));   

                if discrim>0 %compute and note down collision time. 
                    t_c=t_0+(-dot(rel_vel,rel_pos)-sqrt(discrim))/norm(rel_vel)^2;
                    coll_db(1, coll_db_idx)=i;
                    coll_db(2, coll_db_idx)=j;
                    coll_db(3, coll_db_idx)=t_c;
                    coll_db_idx=coll_db_idx+1;
                end

            end
        end
    end
    
    if coll_db(1,1)==0 %If no particles will collide, return empty.. 
        coll_db=[];
    end
    


    %number walls clockwise starting from left
    %1:left, 2:top, 3:right, 4:bot
    wall_coll_db.walls=zeros(1, n_molec);
    wall_coll_db.coll_time=zeros(1, n_molec);

    for i=1:n_molec

        %Dumb checking of each wall
        % For y, x take distance to wall, divide by speed in that component 

        % For x: moving right or left, 
        if vel(1, i)>0
            t_c_x=(box_dim-pos(1,i)-d/2)/abs(vel(1, i));
            cand_wall_x=3; 
        else
            t_c_x=(pos(1,i)-d/2)/abs(vel(1, i));
            cand_wall_x=1;
        end

        %For y: moving up or down 
        if vel(2, i)>0
            t_c_y=(box_dim-pos(2,i)-d/2)/abs(vel(2, i));
            cand_wall_y=2; 
        else
            t_c_y=(pos(2,i)-d/2)/abs(vel(2, i));
            cand_wall_y=4;
        end    

        %Take smallest t_c and update the wall collision times
        if t_c_x<t_c_y
            wall_coll_db.walls(i)=cand_wall_x;
            wall_coll_db.coll_time(i)=t_c_x;
        else
            wall_coll_db.walls(i)=cand_wall_y;
            wall_coll_db.coll_time(i)=t_c_y;        
        end

    end


end
    
