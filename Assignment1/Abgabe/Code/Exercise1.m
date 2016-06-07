function [ par ] = Exercise1( k )
%EXERCISE1 Summary of this function goes here
%   Detailed explanation goes here
load('Data.mat');

%% Resizing input and output data into k subsamples


row_size = floor(size(Input,2)/k);

elements = [Input(1,:).', Input(2,:).', (Input(1,:).*Input(2,:)).'];
input_mod = [elements, elements.^2, elements.^3, elements.^4, elements.^5, elements.^6];
output = Output';

input_fold = mat2cell(input_mod, [row_size*ones(1, k), mod(size(Input,2),row_size)], 18 );
%output_fold = mat2cell(Output.', [row_size*ones(1, k), mod(size(Input,2),row_size)],3 );




%% Performing Linear Regression with training sets

a = {};
position_error = zeros(6,1);
orientation_error = zeros(6,1);


for i=1:k
    down = (i-1)*row_size+1;
    up = (i)*row_size;
    test_output = output(down:up,:);
    test_input = input_mod(down:up,:);
    for j=1:6
        training_input = [input_mod(1:down-1,:); input_mod(up+1:end,:)];
        training_output = [output(1:down-1,:); output(up+1:end,:)];
        if down == 1
            training_input = [input_mod(up+1:end,:)];
            training_output = [output(up+1:end,:)];
        end

        tmp_x = [ones(size(training_input,1),1), training_input(:,1:3*j)];
        w = inv(tmp_x.'*tmp_x)*tmp_x'*training_output;

        y =  [ones(size(test_input,1),1), test_input(:,1:3*j)] * w;
        difference_y = (y-test_output).^2;
        position_error(j) = position_error(j) + mean(sqrt(difference_y(:,1) + difference_y(:,2)));
        orientation_error(j) = orientation_error(j) + mean(sqrt(difference_y(:,3)));
    end
end

%% Params berechnen

[opt_p_error, p1] = min(position_error);
[opt_o_error, p2] = min(orientation_error);


tmp_x = [ones(size(input_mod,1),1), input_mod(:,1:3*p1)];
w = inv(tmp_x.'*tmp_x)*tmp_x'*output;

par{1} = w(:,1);
par{2} = w(:,2);

tmp_x = [ones(size(input_mod,1),1), input_mod(:,1:3*p2)];
w = inv(tmp_x.'*tmp_x)*tmp_x'*output;

par{3} = w(:,3);

save('params','par');

end

