function [ w ] = linear_regression( X,Y )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    w = inv(X.'*X)*X.'*y;

end

