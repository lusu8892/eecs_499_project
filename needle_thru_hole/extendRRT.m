%% extendRRT.m
% This is the function to extend the tree

function q_new = extendRRT( tree, q_rand, step_size, map_info)

    % find the closest neighbor of q among all nodes on current Tree
    [q_near, normalized_dist_min] = nearestNode(tree, q_rand);
    
    % progress q_near by step_size along the straight line in Q btw q_near and q_rand
    [q_new, flag] = getNewNode(q_near, q_rand, step_size, normalized_dist_min);
    if (flag == 0)
        collision = collisionDetection(map_info, q_new);
        if (collision == true)
            q_new = NaN;
        else
            checkThru;
            if ()
                return;
            else
                q_new = NaN;
            end
        end
    else
        checkThru();
        if ()
            return;
        else
            q_new = NaN;
        end
    end
    % 
    
    if (isnan(q_new)) % if q_new == NaN then jump to another iteration
        continue;
    else
        tree = insertNodeToTree( tree, q_near, q_new);
    end


end

%% subfunction to get new node
function [q_new, flag] = getNewNode(q_nearest, q_rand, step_size, distance)
    if ( distance < step_size )
        flag = 1; % q_new = q_rand
        q_new = q_rand;
    else
        q_new.position(1,:) = q_nearest.position(1) + (q_rand.position(1) - q_nearest.position(1)) / distance * step_size;
        q_new.position(2,:) = q_nearest.position(2) + (q_rand.position(2) - q_nearest.position(2)) / distance * step_size;

        if ( abs(q_rand.direction - q_nearest.direction) <= pi )
            q_new.direction = q_nearest.direction + (q_rand.direction - q_nearest.direction) / distance * step_size;
        else %if the angle difference is larger than 180 degrees, we will need to go the other way
             if (q_nearest.direction < q_rand.direction)
                 theta_dist = q_rand.direction - q_nearest.direction - 2*pi;
                 delta_theta = theta_dist / distance * step_size;
                 new_theta = q_nearest.direction + delta_theta;
                 if (new_theta < 0) 
                     new_theta = new_theta + 2*pi;  %if angle became negative, we have to correct it.
                 end
             else
                 theta_dist = q_rand.direction - q_nearest.direction + 2*pi;
                 delta_theta = theta_dist / distance * step_size;
                 new_theta = q_nearest.direction + delta_theta;
                 if (new_theta > 2 * pi) 
                    new_theta = new_theta - 2*pi;  %if angle became larger than 2*pi, we have to correct it.
                 end
             end
             q_new.direction=new_theta;
        end
        flag = 0; % q_new = new node
    end
end

%% subfunction insert
function tree = insertNodeToTree( tree, q_parent, q_new)
    tree.nodeIndex = [tree.nodeIndex; length(tree.nodeIndex) + 1];
    tree.nodeConfig = [tree.nodeConfig; q_new];
    tree.parentNodeIndex = [tree.parentNodeIndex; q_parent.nodeIndex];
end