function LikValues = EvaluateLikelihood(Image, mu,Sigma)
d = size(Image,3);
H = size(Image,1);
W = size(Image,2);
LikValues = zeros(H,W);


for i = 1:H  
    for j = 1:W
        
    x = cast(Image(i,j,:),'double');
    x = reshape(x,[3 1]);
 
    LikValues(i,j) = exp(-0.5*(x - mu')' * inv(Sigma) * (x-mu'))  /((2*pi)^(d/2) * det(Sigma)^1/2);
    
    end
end
        

end