function [ output_args ] = Exercise3_kmeans( gesture_l, gesture_o, gesture_x, init_cluster_l, init_cluster_o, init_cluster_x, k )

kmeans(gesture_l, init_cluster_l, k);
kmeans(gesture_o, init_cluster_o, k);
kmeans(gesture_x, init_cluster_x, k);

end

