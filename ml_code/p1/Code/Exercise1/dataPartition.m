function y = dataPartition(datMat,k)
%partitioning input data in training and testing set for given k

N = size(datMat,2);
y = [];
    for K = 1:k 
        y = [y; datMat(:,1+(K-1)*N/k : K*N/k)];
    end
    
end




