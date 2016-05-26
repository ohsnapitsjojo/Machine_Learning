%% Load parameter

d = 500;

%% Load data

images = loadMNISTImages('train-images.idx3-ubyte'); 
labels = loadMNISTLabels('train-labels.idx1-ubyte');

%% PCA

mean = mean2(images);                       % Compute the mean
tmp_images = images-ones(size(images))*mean;% Make the data zero-mean
S = cov(tmp_images.');                      % Compute Cov Matrix
[V, D] = eig(S);                            % Eigenvectors and Eigenvalues
    
D = sum(D);     
[B, I] = sort(D);
I = fliplr(I);
basis = V(:,I(1:d));                            % Chose the strongest Eigenvectors

y = basis.'*images;                             % Project the data on these basis

%% Computation the man and covaraicne of each digit class seperately

mean_vector = sum(images)/size(images,1);   % calculate mean vector for each image
cov_vector = cov(images(:,1));

for i=1:size(images,1)                      % Substract mean vector from input data
    tmp_images(i,:) = tmp_images(i,:) - mean_vector;
end

y_neu = basis.'*tmp_images;                      % Project Data on already learned basis



