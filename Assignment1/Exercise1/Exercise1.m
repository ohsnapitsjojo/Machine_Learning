function [ par ] = Exercise1( k )
%EXERCISE1 Summary of this function goes here
%   Detailed explanation goes here

load('Data.mat');

%% Resizing input and output data into k subsamples

row_size = floor(size(Input,2)/k);

elements = [Input(1,:).', Input(2,:).', (Input(1,:).*Input(2,:)).'];
elements = [elements, elements.^2, elements.^3, elements.^4, elements.^5, elements.^6];


input_fold = mat2cell(elements, [row_size*ones(1, k), mod(size(Input,2),row_size)], 18 );
output_fold = mat2cell(Output.', [row_size*ones(1, k), mod(size(Input,2),row_size)],3 );



%% Performing Linear Regression with training sets

a = {};
position_error = zeros(6,1);
orientation_error = zeros(6,1);


for i=1:6
    for j=1:k-1
        tmp_fold = input_fold{j};
        tmp_x = [ones(size(tmp_fold,1),1), tmp_fold(1:end,1:3*i)];
        a{i,j} = inv(tmp_x.'*tmp_x)*tmp_x.'*output_fold{j};
                
        y =  [ones(size(tmp_fold,1),1), input_fold{k}(1:end,1:3*i)] * a{i,j};
        difference_y = ((y-output_fold{k}).^2).^(0.5);
        difference_y = sum(difference_y)/size(output_fold{k},1);
        position_error(i) = difference_y(1) + difference_y(2);
        orientation_error(i) = difference_y(3);
        
    end
end


[M, I] =min(position_error);

par{1} = a{I}(:,1);
par{2} = a{I}(:,2);
par{3} = a{I}(:,3);


end

