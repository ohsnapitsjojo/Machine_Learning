function Y = mvGaussian(X,mu,sigma)
	% X is element NxM, N: total number of samples, M: data-dimensionality
	N = size(X,2);
	M = size(X,1);
	Y = [];
	% compute probability and build Nx1 probability vector
	for i=1:N
		tmp = 1/sqrt((2*pi)^M * det(sigma)) * exp(-0.5 * (X(:,i) - mu)' * inv(sigma) * (X(:,i) - mu)); 
		Y   = [Y; tmp];
	end
	
end