function [  ] = plotAll( X, Y, step, cluster, covariance, k, mean, x, name )
%PLOTALL Summary of this function goes here
%   Detailed explanation goes here
figure;
xlabel('X')
ylabel('Y') 
zlabel('Z')
title(name)
hold on;

g = cell(4,1);

for i=1:k
   g{i} = mvnpdf([X(:) Y(:)], mean(i,:),covariance{i});
end
   
plotClusters(cluster);
plotGaussian(X, Y, step, g{1});
plotGaussian(X, Y, step, g{2});
plotGaussian(X, Y, step, g{3});
plotGaussian(X, Y, step, g{4});

end

