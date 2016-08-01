function [  ] = plotClusters( cluster )
%PLOTCLUSTERS Summary of this function goes here
%   Detailed explanation goes here
plot(cluster{1}(1,:), cluster{1}(2,:), 'r.');
plot(cluster{2}(1,:), cluster{2}(2,:), 'b.');
plot(cluster{3}(1,:), cluster{3}(2,:), 'c.');
plot(cluster{4}(1,:), cluster{4}(2,:), 'y.');

end

