%% Load Data and params
load('gesture_dataset.mat');

tmp = gesture_l(:,5,:);
input = [tmp(:,1,1), tmp(:,1,2), tmp(:,1,3)];
means = init_cluster_l;
dod = 420;
d = 420;
class = cell(7,1);
k = 7;
threshold = 10^-6;
euk_distance = zeros(size(input, 1), k);

%% k means



while dod > threshold

    euk_distance = pdist2(input, means);
    [min_d , matched_class] = min(euk_distance' ,[], 1);
    
    tmp_d = 0;
    for i=1:k
        tmp_ind = find(matched_class() == i);
        class{i} = input(tmp_ind,:);
        tmp_d = tmp_d + sum(pdist2(class{i}, means(i,:)));
        if size(class{i}) ~= 0    
            means(i,:) = mean(class{i});
        end
        
    end
    dod = abs(d - tmp_d);
    d = tmp_d;
end

%% Plot 
plot3(class{1}(:,1),class{1}(:,2),class{1}(:,3),'.','color','red');
hold on;
plot3(class{2}(:,1),class{2}(:,2),class{2}(:,3),'.','color','blue');
plot3(class{3}(:,1),class{3}(:,2),class{3}(:,3),'.','color','yellow');
plot3(class{4}(:,1),class{4}(:,2),class{4}(:,3),'.','color','cyan');
plot3(class{5}(:,1),class{5}(:,2),class{5}(:,3),'.','color','green');
plot3(class{6}(:,1),class{6}(:,2),class{6}(:,3),'.','color','black');
plot3(class{7}(:,1),class{7}(:,2),class{7}(:,3),'.','color','magenta');
