function [ priors ] = updatePrior( nK )
%UPDATEPRIOR Summary of this function goes here
%   Detailed explanation goes here
    allN = sum(nK);
    priors = nK/allN;

end

