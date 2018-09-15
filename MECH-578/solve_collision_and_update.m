
function [new_pos, new_vel,updated_idx] = solve_collision_and_update(coll_db, wall_coll_db, pos, vel)

    new_pos=pos; new_vel=vel; %initialize
    sz=size(pos); n_molec=sz(2);
    % GET MINIMUM COLLISION TIME AND UPDATE 
    if ~isempty(coll_db)
        [particle_t_c, particle_idx]=min(coll_db(3,:));
    end
    [wall_t_c, wall_particle_idx]=min(wall_coll_db.coll_time);

    %Particle-Particle Collision
    if ~isempty(coll_db) && particle_t_c<wall_t_c 
        t_c_min=particle_t_c;

        %Update positions
        for i=1:n_molec
            new_pos(:,i)=pos(:,i)+t_c_min*vel(:,i);
        end

        %Update velocities of colliding particles 
        %Find particles in the collision db, getting indices of particles,
        %updating velocities. 
        
        updated_idx=coll_db(1:2,particle_idx);
        %Solve for collision
        for i=coll_db(1,particle_idx)
            for j=coll_db(2, particle_idx)
                %Use formula for post-collision velocity in Haile, derived
                %from getting reference frame with one of the unit vectors
                %through radius between particles and saying all momentum
                %transfer is through that axis. Page 3 (107) EQ 3.17, 3.18 in myCourses doc. 

                rel_pos=pos(:, i)-pos(:,j); rel_pos_unit=rel_pos/norm(rel_pos);

                new_vel(:,i)=vel(:,i)-( ...
                    dot((vel(:,i)-vel(:,j)), rel_pos_unit)*rel_pos_unit);
                new_vel(:,j)=vel(:,j)+( ...
                    dot((vel(:,i)-vel(:,j)), rel_pos_unit)*rel_pos_unit);
            end
        end

    %Particle-Wall Collision
    else
        t_c_min=wall_t_c;
        
        %Update positions
        for i=1:n_molec
            new_pos(:,i)=pos(:,i)+t_c_min*vel(:,i);
        end
        updated_idx = wall_particle_idx;
        wall=wall_coll_db.walls(wall_particle_idx);
        if wall == 1 || wall == 3 %Left or right wall
            new_vel(1, wall_particle_idx) = -vel(1, wall_particle_idx);
        else %Top or bot wall
            new_vel(2, wall_particle_idx) = -vel(2, wall_particle_idx);
        end

    end
end