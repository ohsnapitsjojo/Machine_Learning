function [ output_args ] = nubs( gesture, k )
%NUBS Summary of this function goes here
%   Detailed explanation goes here
figure();

v = [0.08, 0.05, 0.02];

    tmp_k = 1;
    d = cell(k,1);
    y = cell(k,1);
    cluster = cell(k,1);

    input = reshape(gesture,600,3);    
    cluster{1} = input;
    
    while tmp_k ~= k

        for i=1:k-1
            if size(cluster{i}) == 0
               y{i} = [0,0,0]; 
               d{i} = 0;
            else
            y{i} = mean(cluster{i});
            d{i} = sum(pdist2(y{i}, cluster{i}));

            end
        end
        
        [M,I] = max(cell2mat(d));
        
        Xa = y{I} + v;
        Xb = y{I} - v;

        dist_a = pdist2(cluster{I}, Xa);
        dist_b = pdist2(cluster{I}, Xb);
        
        the_sorting_hat = dist_a < dist_b;
        
        tmp_ind = find(the_sorting_hat == 1);
        cluster{tmp_k+1} = cluster{I}(tmp_ind,:);
        tmp_ind = find(the_sorting_hat == 0);
        cluster{I} = cluster{I}(tmp_ind,:);

        tmp_k = tmp_k +1;
        
    end
    plot3(cluster{1}(:,1),cluster{1}(:,2),cluster{1}(:,3),'.','color','red');
    hold on;
    plot3(cluster{2}(:,1),cluster{2}(:,2),cluster{2}(:,3),'.','color','blue');
    plot3(cluster{3}(:,1),cluster{3}(:,2),cluster{3}(:,3),'.','color','yellow');
    plot3(cluster{4}(:,1),cluster{4}(:,2),cluster{4}(:,3),'.','color','cyan');
    plot3(cluster{5}(:,1),cluster{5}(:,2),cluster{5}(:,3),'.','color','green');
    plot3(cluster{6}(:,1),cluster{6}(:,2),cluster{6}(:,3),'.','color','black');
    plot3(cluster{7}(:,1),cluster{7}(:,2),cluster{7}(:,3),'.','color','magenta');



end



