function [ mu, cov, prior, gNeu, ll, clusters ] = updateGMM( g, prior, x)
%UPDATE Summary of this function goes here
%   Detailed explanation goes here
    response = calculateResponsibility( g, prior );
    [nK, clusters] = updateNK(response, x);
    mu = updateMean( response, x, nK );
    cov = updateCov( response, mu, x, nK );
    prior = updatePrior( nK );
    ll = calculateLL( g, prior );
    
    gNeu{1} = mvnpdf(x, mu(1,:),cov{1});
    gNeu{2} = mvnpdf(x, mu(2,:),cov{2});
    gNeu{3} = mvnpdf(x, mu(3,:),cov{3});
    gNeu{4} = mvnpdf(x, mu(4,:),cov{4});
end

