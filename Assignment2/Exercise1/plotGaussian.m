function [  ] = plotGaussian( X, Y, step, g )
%PLOT Summary of this function goes here
%   Detailed explanation goes here


Z = reshape(g,size(X));

contour(X,Y,Z)


end

