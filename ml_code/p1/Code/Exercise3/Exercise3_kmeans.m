function Exercise3_kmeans(gesture_l,gesture_o,gesture_x,init_cluster_l,init_cluster_o,init_cluster_x,k)

tic
%number of repetitions/gestures is equal for all sets
repetitions = size(gesture_l,2);
gestures =size(gesture_l,1);

%colors for class plots
colors = ['blue   ';'black  ';'red    ';'green  ';'magenta';'yellow ';'cyan   '];
colorvec = cellstr(colors);

%init clusters
Y_l = init_cluster_l;
Y_o = init_cluster_o;
Y_x = init_cluster_x;
%%
%total distortion crit
J_l = 0;
J_o = 0;
J_x = 0;
J_old = 1e10;
criterion = 1e-6;
    
loop_count = 1;
%%
while true
%%   
    %correspondence matrices
    Corr_l = [];
    Corr_o = [];
    Corr_x = [];
    %for each datapoint in a set determine the euclidean distance
    for i=1:repetitions
        for j= 1:gestures
            %get datapoint
            x_l = reshape(gesture_l(j,i,:),[3 1]);       
            x_o = reshape(gesture_o(j,i,:),[3 1]); 
            x_x = reshape(gesture_x(j,i,:),[3 1]); 

            d_min_l = 1e10;
            d_min_o = 1e10;
            d_min_x = 1e10;

            for l=1:k
            %calcutlate eucledian distance for all clusters
                d_l = sqrt(sum((Y_l(l,:)'-x_l).^2));         
                if d_l < d_min_l             
                   label_l = l;
                   d_min_l = d_l; 
                end   
            end


             for o=1:k
            %calcutlate eucledian distance for all clusters
                d_o = sqrt(sum((Y_o(o,:)'-x_o).^2));         
                if d_o < d_min_o             
                   label_o = o;
                   d_min_o= d_o; 
                end   
            end       


            for x=1:k
            %calcutlate eucledian distance for all clusters
                d_x = sqrt(sum((Y_x(x,:)'- x_x).^2));         
                if d_x < d_min_x             
                   label_x = x;
                   d_min_x = d_x; 
                end   
            end        

            %Correspondence matrix : A = [repetition;gesture;label]
            entry_tmp_l = [i;j;label_l];
            entry_tmp_o = [i;j;label_o];
            entry_tmp_x = [i;j;label_x];

            Corr_l = [Corr_l entry_tmp_l];
            Corr_o = [Corr_o entry_tmp_o];
            Corr_x = [Corr_x entry_tmp_x];

        end 
    end
 %%   
    %update clusters
    for i= 1:k
        get_l = find(Corr_l(3,:)== i);
        get_o = find(Corr_o(3,:)== i);
        get_x = find(Corr_x(3,:)== i);
        
        x_tmp_l = zeros(3,1);
        x_tmp_o = zeros(3,1);
        x_tmp_x = zeros(3,1);
        
        for j= 1:size(get_l,2)
            corr_col = Corr_l(:,get_l(j));
            idx_rep = corr_col(1);
            idx_ges = corr_col(2);
            
            x_tmp_l = x_tmp_l + reshape(gesture_l(idx_ges,idx_rep,:),[3 1]);        
        end
        
        for j= 1:size(get_o,2)
            corr_col = Corr_o(:,get_o(j));
            idx_rep = corr_col(1);
            idx_ges = corr_col(2);
            
            x_tmp_o = x_tmp_o + reshape(gesture_o(idx_ges,idx_rep,:),[3 1]);        
        end        
        
         for j= 1:size(get_x,2)
             corr_col = Corr_x(:,get_x(j));
             idx_rep = corr_col(1);
             idx_ges = corr_col(2);
             
             x_tmp_x = x_tmp_x + reshape(gesture_x(idx_ges,idx_rep,:),[3 1]);        
         end        
        
        
        
        Y_l(i,:) = x_tmp_l/size(get_l,2); 
        Y_o(i,:) = x_tmp_o/size(get_o,2); 
        Y_x(i,:) = x_tmp_x/size(get_x,2); 
       
    end
    
    
    %calculate total distortion
    for i= 1:k
 
        x_tmp_l = zeros(3,1);
        x_tmp_o = zeros(3,1);
        x_tmp_x = zeros(3,1);
        
        for j= 1:size(get_l,2)
            corr_col = Corr_l(:,get_l(j));
            idx_rep = corr_col(1);
            idx_ges = corr_col(2);
            
            x_tmp_l = reshape(gesture_l(idx_ges,idx_rep,:),[3 1]); 
            
            J_l = J_l + sqrt(sum((Y_l(i,:)' - x_tmp_l).^2));            
        end
        
        for j= 1:size(get_o,2)
            corr_col = Corr_o(:,get_o(j));
            idx_rep = corr_col(1);
            idx_ges = corr_col(2);
            
            x_tmp_o = reshape(gesture_o(idx_ges,idx_rep,:),[3 1]); 
            
            J_o = J_o + sqrt(sum((Y_o(i,:)' - x_tmp_o).^2));            
        end        
        
        
         for j= 1:size(get_x,2)
             corr_col = Corr_x(:,get_x(j));
             idx_rep = corr_col(1);
             idx_ges = corr_col(2);
             
             x_tmp_x = reshape(gesture_x(idx_ges,idx_rep,:),[3 1]); 
             
             J_x = J_x + sqrt(sum((Y_x(i) - x_tmp_x).^2));            
         end        
      
    end
    
    %exit loop if J is small enough
    
    J = J_l + J_o+ J_x;
    
    if (J_old-J) < criterion
       fprintf('Number of iterations: %d\n',loop_count);

       %get respective matrices for each class
       
       
       for i= 1:k
        A_l = [];
        A_o = [];
        A_x = [];
        get_l = find(Corr_l(3,:)== i);
        get_o = find(Corr_o(3,:)== i);
        get_x = find(Corr_x(3,:)== i);
            for j =  1:size(get_l,2)
                
                corr_col = Corr_l(:,get_l(j));
                idx_rep = corr_col(1);
                idx_ges = corr_col(2);

                A_l = [A_l reshape(gesture_l(idx_ges,idx_rep,:),[3 1])];
                
            end
            
            for j =  1:size(get_o,2)
                
                corr_col = Corr_o(:,get_o(j));
                idx_rep = corr_col(1);
                idx_ges = corr_col(2);

                A_o = [A_o reshape(gesture_o(idx_ges,idx_rep,:),[3 1])];
                
            end
            
            for j =  1:size(get_x,2)
                
                corr_col = Corr_x(:,get_x(j));
                idx_rep = corr_col(1);
                idx_ges = corr_col(2);

                A_x = [A_x reshape(gesture_x(idx_ges,idx_rep,:),[3 1])];
                
            end
       
       figure(1)
       hold on
       plot(A_o(1,:),A_o(2,:),'color',colorvec{i});
       title('Gesture o')
       %plot(Y_o(:,1),Y_o(:,2),'x');
       figure(2)
       hold on
       plot(A_l(1,:),A_l(2,:),'color',colorvec{i});
       %plot(Y_l(:,1),Y_l(:,2),'x');
       title('Gesture l')
       figure(3)
       hold on
       plot(A_x(1,:),A_x(2,:),'color',colorvec{i});
       %plot(Y_x(:,1),Y_x(:,2),'x');
       title('Gesture x')       

       end
       toc
       break 
    end
    
    %else set J to zero and repeat whole process
    J_old = J;
    J_l = 0;
    J_o = 0;
    J_x = 0;
    loop_count = loop_count+1;
end

%%
%plot data with different colors



