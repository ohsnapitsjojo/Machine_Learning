function [ cov ] = updateSingleCov( response, mu, x, nK )
%UPDATESINGLECOV Summary of this function goes here
%   Detailed explanation goes here

    xNew = x - (mu'*ones(1, size(x, 1)))';
    xNewer = (response*ones(1,2)) .* xNew;
    cov =  (xNewer'*xNew)/nK;
end

