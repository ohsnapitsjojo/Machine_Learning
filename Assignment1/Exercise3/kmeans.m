function [ output_args ] = kmeans( gesture, init_cluster, k )
%EXERCISE3_KMEANS Summary of this function goes here
%   Detailed explanation goes here

% Params
figure();

euk_distance = zeros(size(gesture, 1), k);
class = cell(10,7);
threshold = 10^-6;

for j=1:size(gesture, 2)
    dod = 420;
    d = 420;
    tmp = gesture(:,j,:);
    input = [tmp(:,1,1), tmp(:,1,2), tmp(:,1,3)];
    means = init_cluster;
    
    while dod > threshold

        euk_distance = pdist2(input, means);
        [min_d , matched_class] = min(euk_distance' ,[], 1);

        tmp_d = 0;
        for i=1:k
            tmp_ind = find(matched_class() == i);
            class{j,i} = input(tmp_ind,:);
            tmp_d = tmp_d + sum(pdist2(class{j,i}, means(i,:)));
            if size(class{j,i}) ~= 0    
                means(i,:) = mean(class{j,i});
            end

        end
        dod = abs(d - tmp_d);
        d = tmp_d;
    end
    plot3(class{j,1}(:,1),class{j,1}(:,2),class{j,1}(:,3),'.','color','red');
    hold on;
    plot3(class{j,2}(:,1),class{j,2}(:,2),class{j,2}(:,3),'.','color','blue');
    plot3(class{j,3}(:,1),class{j,3}(:,2),class{j,3}(:,3),'.','color','yellow');
    plot3(class{j,4}(:,1),class{j,4}(:,2),class{j,4}(:,3),'.','color','cyan');
    plot3(class{j,5}(:,1),class{j,5}(:,2),class{j,5}(:,3),'.','color','green');
    plot3(class{j,6}(:,1),class{j,6}(:,2),class{j,6}(:,3),'.','color','black');
    plot3(class{j,7}(:,1),class{j,7}(:,2),class{j,7}(:,3),'.','color','magenta');


end

end

