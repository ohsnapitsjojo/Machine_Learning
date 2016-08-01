function [ ll ] = calculateLL( g, priors )
%CALCULATELL Summary of this function goes here
%   Detailed explanation goes here
    ll = sum(log(priors(1)*g{1}+priors(2)*g{2}+priors(3)*g{3}+priors(4)*g{4}));
end

