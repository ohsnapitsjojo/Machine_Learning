%% Load parameter
clear all;
tic;

d = 500;

%% Load data

images = loadMNISTImages('train-images.idx3-ubyte'); 
labels = loadMNISTLabels('train-labels.idx1-ubyte');
test_images = loadMNISTImages('t10k-images.idx3-ubyte');
test_labels = loadMNISTLabels('t10k-labels.idx1-ubyte');

%% PCA

means = mean2(images);                       % Compute the mean
tmp_images = images - means;% Make the data zero-mean
S = cov(tmp_images.');                      % Compute Cov Matrix
[V, D] = eig(S);                            % Eigenvectors and Eigenvalues
    
D = diag(D);     
[B, I] = sort(D);
I = fliplr(I);
basis = V(:,I(1:d));                            % Chose the strongest Eigenvectors

y = basis.'*images;                             % Project the data on these basis

%% Computation of the mean and covaraicne of each digit class seperately

class = cell(10,1);
mean_class = cell(10,1);
cov_class = cell(10,1);
proj_class = cell(10,1);
l_class = cell(10,1);

mean_vector = zeros(1,9);
tmp_sum = mean(images);
cov_vector = zeros(1,9);

for i=0:9

    
    tmp_ind = find(test_labels == i);
    tmp_mean = tmp_sum(:,tmp_ind);
    mean_class{i+1} = mean(tmp_mean);
    class{i+1} = test_images(:,tmp_ind) - ones(size(test_images,1),1)*tmp_mean;
    cov_class{i+1} = cov(class{i+1}'); 
    proj_class{i+1} = basis.'*class{i+1};
    
end




toc;

% cov_vector = cov(y(:,1));
% 
% for i=1:size(y,1)                      % Substract mean vector from input data
%     tmp_images(i,:) = tmp_images(i,:) - mean_vector;
% end
% 
% y_neu = basis.'*tmp_images;                      % Project Data on already learned basis



