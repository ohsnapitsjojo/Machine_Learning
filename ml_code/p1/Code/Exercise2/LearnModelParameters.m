function [mu, Sigma] = LearnModelParameters(DirectoryName, n,p)

files = dir(DirectoryName);
rgbValues = [];


for i=1+2:n+2
  
 abs_path = strcat(strcat(DirectoryName,'\\'),files(i).name);
 %get middle region
 CenterPixels = ExtractCenterPixels(abs_path,p);
 
 %reshape and cast to double
 rgbValues =  [rgbValues;cast(reshape(CenterPixels,...
     [size(CenterPixels,1)*size(CenterPixels,2), 3]),'double')];
   

 %get mu and cov from region

end
 
 mu = mean(rgbValues);
 Sigma = cov(rgbValues); 

end