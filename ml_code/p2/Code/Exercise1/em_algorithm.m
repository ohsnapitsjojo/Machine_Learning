clear
load data1.mat

cluster_no = 4;
N = size(Data,2);

% convergence threshold
epsilon = 1e-9;
finished = 0;
iterations = 1;
ll_old = 0;

%GMM paramaters needed
means = [];
covs = [];
priors = [];

idx = kmeans(Data',cluster_no);

for i = 1:cluster_no
   % init priors with equal values  
   priors = [priors 1/cluster_no];
   % get samples belonging to classes wrt kmeans and build datamatrix
   tmp = find(idx==i);
   len = size(tmp(:),1);      
   data = [];
  for j=1:len
      data = [data Data(:,tmp(j))]; 
  end
   % calculate mean and covaraince matrix from datamatrix
   means = [means mean(data')'];
   covs  = cat(3,covs,cov(data'));
end

%%
% initialize pdfs
pdf = [];
for i = 1: cluster_no
    pdf = [pdf mvGaussian(Data,means(:,i),covs(:,:,i)) ];
end

while(not(finished))
%%
    %E-step: calculate the posteriors
    posteriors = [];
    for i = 1:cluster_no
        tmp_posterior = [];
        for j = 1:N
            tmp_posterior = [tmp_posterior ; priors(i) * pdf(j,i)/(priors * pdf(j,:)')];
        end
        posteriors = [posteriors tmp_posterior];
    end

%%
    % M-Step: update mean, cov, priors
    for i = 1:cluster_no
        n = sum(posteriors(:,i));
        mean_tmp = zeros(3,1);
        cov_tmp = zeros(3,3);

        for j=1:N
            mean_tmp = mean_tmp + posteriors(j,i) * Data(:,j); 
        end

        means(:,i) = 1/n * mean_tmp;
        priors(i) = n/N;

        for j=1:N
            x_tmp = Data(:,j);
            cov_tmp = cov_tmp + posteriors(j,i) * (x_tmp - means(:,i)) * (x_tmp - means(:,i))';
        end
        covs(:,:,i) = 1/n * cov_tmp;  
    end


%%
    % recalculate the pdfs
    pdf = [];

    for i = 1:cluster_no
        pdf = [pdf mvGaussian(Data,means(:,i),covs(:,:,i))];
    end
    
    % calculate log likelihood
    ll_tmp = 0;
    for i=1:N
        ll_tmp = ll_tmp + log(priors * pdf(i,:)');      
    end
    
    % check for convergence
    if(abs(ll_old - ll_tmp) > epsilon)
       ll_old = ll_tmp;
       iterations = iterations + 1; 
    else
        finished = 1;
        fprintf('iterations: %d\n',iterations);
    end  
    
end