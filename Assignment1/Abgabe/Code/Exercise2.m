function [ optimal_d, optimal_error, c_mat ] = Exercise2( d )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

images = loadMNISTImages('train-images.idx3-ubyte'); 
labels = loadMNISTLabels('train-labels.idx1-ubyte');
test_images = loadMNISTImages('t10k-images.idx3-ubyte');
test_labels = loadMNISTLabels('t10k-labels.idx1-ubyte');

errors = zeros(d,1);
classes = cell(d,1);

    for i=1:d
        
        [errors(i), classes{i}] = bayes_classifier( images, labels, test_images, test_labels, i);
    end
    
x_axis = [1:1:d];

[optimal_error, optimal_d] = min(errors);
c_mat = confusionmat(test_labels, classes{optimal_d});
figure;
scatter(x_axis, errors);
xlabel('d')
ylabel('Missmatch Rate')
title('Missmatch Rate over values of d')
grid on
    
end


