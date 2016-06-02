%% Load parameter
clear all;
tic;


%% Load data

images = loadMNISTImages('train-images.idx3-ubyte'); 
labels = loadMNISTLabels('train-labels.idx1-ubyte');
test_images = loadMNISTImages('t10k-images.idx3-ubyte');
test_labels = loadMNISTLabels('t10k-labels.idx1-ubyte');

%% PCA

means = mean2(images);                       % Compute the mean
tmp_images = images - means;                % Make the data zero-mean
S = cov(tmp_images.');                      % Compute Cov Matrix
[V, D] = eig(S);                            % Eigenvectors and Eigenvalues
    
D = diag(D);     
[B, I] = sort(D, 'descend');

basis = V(:,I(1:d));                            % Chose the strongest Eigenvectors

y = basis.'*images;                             % Project the data on these basis

%% Computation of the mean and covaraicne of each digit class seperately




class_y = cell(10,1);
mean_class = cell(10,1);
mean_class_y = cell(10,1);
cov_class_y = cell(10,1);

tmp_sum = mean(images);

if size(y,1)>1
    tmp_sum_y = mean(y);
else
    tmp_sum_y = y;
end

for i=0:9

    
    tmp_ind = find(labels == i);
    tmp_mean = tmp_sum(:,tmp_ind);
    tmp_mean_y = tmp_sum_y(:,tmp_ind);
    mean_class{i+1} = mean(tmp_mean);
    mean_class_y{i+1} = mean(tmp_mean_y);
    class_y{i+1} = y(:,tmp_ind);
    cov_class_y{i+1} = cov(class_y{i+1}');
end

      
        

for i=1:10
    test_proj = basis.'*(test_images-mean_class{i});
    l(:,i) = mvnpdf(test_proj', mean_class_y{i}, cov_class_y{i});
    
end

[max_l , matched_class] = max(l,[],2);

matched_class = matched_class - 1;

error = sum(matched_class~=test_labels)/length(test_labels);

toc;




