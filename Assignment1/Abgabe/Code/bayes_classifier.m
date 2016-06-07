function [ error, matched_class ] = bayes_classifier( images, labels, test_images, test_labels, d)
%% PCA

means = mean(images');                       % Compute the mean
tmp_images = bsxfun(@minus, images, means');  % Make the data zero-mean
S = cov(tmp_images');                      % Compute Cov Matrix
[V, D] = eig(S);                            % Eigenvectors and Eigenvalues
D = diag(D);     
[B, I] = sort(D, 'descend');
basis = V(:,I(1:d));                            % Chose the strongest Eigenvectors
y = basis.'*tmp_images;                             % Project the data on these basis

%% Computation of the mean and covaraicne of each digit class seperately

zm_test_images = bsxfun(@minus, test_images, means');

class_y = cell(10,1);
mean_class_y = cell(10,1);
cov_class_y = cell(10,1);

for i=0:9
    
    tmp_ind = find(labels == i);
    class_y{i+1} = y(:,tmp_ind);
    cov_class_y{i+1} = cov(class_y{i+1}');
    mean_class_y{i+1} = mean(class_y{i+1}');

end

      

for i=1:10
    test_proj = basis.'*(zm_test_images);
    l(:,i) = mvnpdf(test_proj', mean_class_y{i}, cov_class_y{i});
    
end

[max_l , matched_class] = max(l,[],2);

matched_class = matched_class - 1;
error = sum(matched_class~=test_labels)/length(test_labels);

end

