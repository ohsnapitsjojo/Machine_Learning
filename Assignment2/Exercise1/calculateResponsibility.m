function [ response ] = calculateResponsibility( g, prior )
%CALCULATERESPONSIBILITY Summary of this function goes here
%   Detailed explanation goes here
    response = zeros(300,4);
    nenner = prior(1)*g{1} + prior(2)*g{2} + prior(3)*g{3} + prior(4)*g{4};
    
    response(:,1) = (prior(1)*g{1})./nenner;
    response(:,2) = (prior(2)*g{2})./nenner;
    response(:,3) = (prior(3)*g{3})./nenner;
    response(:,4) = (prior(4)*g{4})./nenner;


end

