%% Load Data and params
load('gesture_dataset.mat');

tmp = gesture_l(:,2,:);
input = [tmp(:,1,1), tmp(:,1,2), tmp(:,1,3)];
means = init_cluster_l;
k = 7;
threshold = 10^-6;

%% k means

dod = 420;
euk_distance = zeros(size(input, 1), k);
class = cell(7,1);

while dod > threshold

    euk_distance = pdist2(input, means);
    [min_d , matched_class] = min(euk_distance' ,[], 1);
    
    tmp_dod = 0;
    for i=1:k
        tmp_ind = find(matched_class() == i);
        class{i} = input(tmp_ind,:);
        tmp_dod = tmp_dod + sum(pdist2(class{i}, means(i,:)));
        if size(class{i}) ~= 0    
            means(i,:) = mean(class{i});
        end
        
    end
    dod = abs(dod - tmp_dod)
    
end