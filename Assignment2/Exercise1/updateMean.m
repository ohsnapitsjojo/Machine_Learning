function [ mu ] = updateMean( response, x, nK )
%UPDATEMEAN Summary of this function goes here
%   Detailed explanation goes here
    A = cell(4, 1);
    mu = zeros(4, 2);

    A{1} = (response(:,1)*ones(1, 2)) .* x;
    A{2} = (response(:,2)*ones(1, 2)) .* x;
    A{3} = (response(:,3)*ones(1, 2)) .* x;
    A{4} = (response(:,4)*ones(1, 2)) .* x;

    mu(1,:) = (sum(A{1})/nK(1))';
    mu(2,:) = (sum(A{2})/nK(2))';
    mu(3,:) = (sum(A{3})/nK(3))';
    mu(4,:) = (sum(A{4})/nK(4))';

end

