function [ cov ] = updateCov( response, mu, x, nK )
%UPDATECOV Summary of this function goes here
%   Detailed explanation goes here
    cov = cell(4, 1);

    cov{1} = updateSingleCov( response(:,1), mu(1,:), x, nK(1) );
    cov{2} = updateSingleCov( response(:,2), mu(2,:), x, nK(2) );
    cov{3} = updateSingleCov( response(:,3), mu(3,:), x, nK(3) );
    cov{4} = updateSingleCov( response(:,4), mu(4,:), x, nK(4) );

    

end

