%% nearestNode.m
function [ q_near, dist_min ] = nearestNode( tree, q_rand )
%NEARESTNODE Summary of this function goes here
%   Detailed explanation goes here

    node_num = length(tree.nodeIndex);
    dist_vec = [];
    for i = 1:node_num
        % calculate dist btw q_rand and current selected existed onde on tree
        dist = findNearestNode(tree.nodeConfig(node_num), q_rand);
        % store this dist in vector
        dist_vec = [dist_vec; dist];
    end
    
    [dist_min, index] = min(dist_vec);
    q_near = tree.nodeConfig(index);
    
end

%% subfunction to find the nearest node on the current tree wrt to q_rand node
function dist = findNearestNode(q_selected, q_rand)
    x_rand = q_rand.position(1);
    y_rand = q_rand.position(2);
    z_rand = q_rand.position(3);
    theta_rand = q_rand.direction;
    
    x_selected = q_selected.position(1);
    y_selected = q_selected.position(2);
    z_selected = q_selected.position(3);
    theta_selected = q_selected.direction;
    
    theta_min = findThetaMin(theta_rand, theta_selected);
    
    x_span = 100;
    y_span = 100;
    z_span = 0;
    
    dist = 1/3 * (((x_rand - x_selected)/x_span)^2 + ((y_rand - y_selected)/y_span)^2 ...
                    + theta_min/((2*pi)^2));
end