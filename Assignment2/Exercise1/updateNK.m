function [ nK, clusters ] = updateNK( response, x )
%UPDATENK Summary of this function goes here
%   Detailed explanation goes here
    x = x';
    nK = zeros(4,1);
    clusters = cell(4,1);
    
    [M, I] = max(response');
    I = I';
    
    for i=1:4
       clusters{i} = x(:,find(I == i));
       nK(i) = size( clusters{i}, 2);
    end
    
end

