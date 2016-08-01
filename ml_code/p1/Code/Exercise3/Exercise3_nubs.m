function Exercise3_kmeans(gesture_l,gesture_o,gesture_x,K)

tic
repetitions = size(gesture_o,2);
gestures =size(gesture_o,1);
Y_l =[];
Y_o =[];
Y_x =[];

Corr_l = [];
Corr_o = [];
Corr_x = [];

k=1;
loop_count = 0;

%colors for class plots
colors = ['blue   ';'black  ';'red    ';'green  ';'magenta';'Yellow ';'cyan   '];
colorvec = cellstr(colors);

%calculate center of all data points and initialize Corr_lespondence matrix
x_tmp= zeros(3,1);
for i =1:repetitions   
    for j =1:gestures
        x_tmp = x_tmp + reshape(gesture_l(j,i,:),[3 1]);
        Corr_l = [Corr_l [i;j;1]];
    end
end
Y_l = [Y_l ;(x_tmp/(repetitions*gestures))'];


x_tmp= zeros(3,1);
for i =1:repetitions   
    for j =1:gestures
        x_tmp = x_tmp + reshape(gesture_x(j,i,:),[3 1]);
        Corr_x = [Corr_x [i;j;1]];
    end
end

Y_x = [Y_x ;(x_tmp/(repetitions*gestures))'];

x_tmp= zeros(3,1);
for i =1:repetitions   
    for j =1:gestures
        x_tmp = x_tmp + reshape(gesture_o(j,i,:),[3 1]);
        Corr_o = [Corr_o [i;j;1]];
    end
end

Y_o = [Y_o ;(x_tmp/(repetitions*gestures))'];

%%
%algorithm start
while true
    loop_count = loop_count +1;
    if K==1
        break;
    end
%choose class with largest distortion
    J_max_l = 1e-10;
    J_max_o = 1e-10;
    J_max_x = 1e-10;
	
    for i = 1:k
        J= 0;
        x_tmp= zeros(3,1);
        get_class = find(Corr_l(3,:)== i);  
		
        for j=1:size(get_class,2)
            Corr_l_col = Corr_l(:,get_class(j));
            idx_rep = Corr_l_col(1);
            idx_ges = Corr_l_col(2);
            x_tmp = reshape(gesture_l(idx_ges,idx_rep,:),[3 1]); 
			
            J=  J+(sqrt(sum((Y_l(i,:)' - x_tmp).^2)))/size(get_class,2);
        end
		%label class with highest distortion
        if J>J_max_l       
            class_label_l = i;
            J_max_l = J;
        end

    end
    
    for i = 1:k
        J= 0;
        x_tmp= zeros(3,1);
        get_class = find(Corr_o(3,:)== i);  
		
        for j=1:size(get_class,2)
            Corr_o_col = Corr_o(:,get_class(j));
            idx_rep = Corr_o_col(1);
            idx_ges = Corr_o_col(2);
            x_tmp = reshape(gesture_o(idx_ges,idx_rep,:),[3 1]); 
			
            J=  J+(sqrt(sum((Y_o(i,:)' - x_tmp).^2)))/size(get_class,2);
        end
		%label class with highest distortion
        if J>J_max_o       
            class_label_o = i;
            J_max_o = J;
        end

    end
    
    for i = 1:k
        J= 0;
        x_tmp= zeros(3,1);
        get_class = find(Corr_x(3,:)== i);  
		
        for j=1:size(get_class,2)
            Corr_x_col = Corr_x(:,get_class(j));
            idx_rep = Corr_x_col(1);
            idx_ges = Corr_x_col(2);
            x_tmp = reshape(gesture_x(idx_ges,idx_rep,:),[3 1]); 
			
            J=  J+(sqrt(sum((Y_x(i,:)' - x_tmp).^2)))/size(get_class,2);
        end
		%label class with highest distortion
        if J>J_max_x       
            class_label_x = i;
            J_max_x = J;
        end

    end
    

%%
    
    %split class with small random vector
    v = rand(1,3);
    k = k+1;
    
    center_1_l = Y_l(class_label_l,:) + v; 
    center_2_l = Y_l(class_label_l,:) - v; 
    
    center_1_o = Y_o(class_label_o,:) + v; 
    center_2_o = Y_o(class_label_o,:) - v; 
    
    center_1_x = Y_x(class_label_x,:) + v; 
    center_2_x = Y_x(class_label_x,:) - v; 
    
    get_class_l = find(Corr_l(3,:)== class_label_l);
    get_class_o = find(Corr_o(3,:)== class_label_o);
    get_class_x = find(Corr_x(3,:)== class_label_x);
    
    for j=1:size(get_class_l,2)

        Corr_l_col = Corr_l(:,get_class_l(j));
        idx_rep = Corr_l_col(1);
        idx_ges = Corr_l_col(2);

        x_tmp = reshape(gesture_l(idx_ges,idx_rep,:),[3 1]); 


        d_1= sqrt(sum((center_1_l'-x_tmp).^2)); 
        d_2= sqrt(sum((center_2_l'-x_tmp).^2)); 

        if d_2 < d_1
            Corr_l(3,get_class_l(j)) = k;
        end   
    end
    
    for j=1:size(get_class_o,2)

        Corr_o_col = Corr_o(:,get_class_o(j));
        idx_rep = Corr_o_col(1);
        idx_ges = Corr_o_col(2);

        x_tmp = reshape(gesture_o(idx_ges,idx_rep,:),[3 1]); 


        d_1= sqrt(sum((center_1_o'-x_tmp).^2)); 
        d_2= sqrt(sum((center_2_o'-x_tmp).^2)); 

        if d_2 < d_1
            Corr_o(3,get_class_o(j)) = k;
        end   
    end
    
    for j=1:size(get_class_x,2)

        Corr_x_col = Corr_x(:,get_class_x(j));
        idx_rep = Corr_x_col(1);
        idx_ges = Corr_x_col(2);

        x_tmp = reshape(gesture_x(idx_ges,idx_rep,:),[3 1]); 


        d_1= sqrt(sum((center_1_x'-x_tmp).^2)); 
        d_2= sqrt(sum((center_2_x'-x_tmp).^2)); 

        if d_2 < d_1
            Corr_x(3,get_class_x(j)) = k;
        end   
    end

%%
    %update code vectors
    get_class_l = find(Corr_l(3,:)== class_label_l);
    get_class_o = find(Corr_o(3,:)== class_label_o);
    get_class_x = find(Corr_x(3,:)== class_label_x);
    
    %for l gesture
    x_tmp = zeros(3,1);
    for j=1:size(get_class_l,2)
        Corr_l_col = Corr_l(:,get_class_l(j));
        idx_rep = Corr_l_col(1);
        idx_ges = Corr_l_col(2);

        x_tmp = reshape(gesture_l(idx_ges,idx_rep,:),[3 1]) + x_tmp; 
    end

    Y_l(class_label_l,:) = (x_tmp/(size(get_class_l,2)))';

    get_class_l = find(Corr_l(3,:)== k); 
    x_tmp = zeros(3,1);

    for j=1:size(get_class_l,2)
        Corr_l_col = Corr_l(:,get_class_l(j));
        idx_rep = Corr_l_col(1);
        idx_ges = Corr_l_col(2);

        x_tmp = reshape(gesture_l(idx_ges,idx_rep,:),[3 1]) + x_tmp; 
    end
    
    Y_l = [Y_l;(x_tmp/size(get_class_l,2))'];
    
    %for o gesture
        x_tmp = zeros(3,1);
    for j=1:size(get_class_o,2)
        Corr_o_col = Corr_o(:,get_class_o(j));
        idx_rep = Corr_o_col(1);
        idx_ges = Corr_o_col(2);

        x_tmp = reshape(gesture_o(idx_ges,idx_rep,:),[3 1]) + x_tmp; 
    end

    Y_o(class_label_o,:) = (x_tmp/(size(get_class_o,2)))';

    get_class_o = find(Corr_o(3,:)== k); 
    x_tmp = zeros(3,1);

    for j=1:size(get_class_o,2)
        Corr_o_col = Corr_o(:,get_class_o(j));
        idx_rep = Corr_o_col(1);
        idx_ges = Corr_o_col(2);

        x_tmp = reshape(gesture_o(idx_ges,idx_rep,:),[3 1]) + x_tmp; 
    end
    Y_o = [Y_o;(x_tmp/size(get_class_o,2))'];
    
    
    
    %for x gesture
        x_tmp = zeros(3,1);
    for j=1:size(get_class_x,2)
        Corr_x_col = Corr_x(:,get_class_x(j));
        idx_rep = Corr_x_col(1);
        idx_ges = Corr_x_col(2);

        x_tmp = reshape(gesture_x(idx_ges,idx_rep,:),[3 1]) + x_tmp; 
    end

    Y_x(class_label_x,:) = (x_tmp/(size(get_class_x,2)))';

    get_class_x = find(Corr_x(3,:)== k); 
    x_tmp = zeros(3,1);

    for j=1:size(get_class_x,2)
        Corr_x_col = Corr_x(:,get_class_x(j));
        idx_rep = Corr_x_col(1);
        idx_ges = Corr_x_col(2);

        x_tmp = reshape(gesture_x(idx_ges,idx_rep,:),[3 1]) + x_tmp; 
    end
  
    Y_x = [Y_x;(x_tmp/size(get_class_x,2))'];
%%
    if k==K   
       %get respective matrices for each class
       for i= 1:k
        A_l = [];
        A_o = [];  
        A_x = [];  
        get_class_l = find(Corr_l(3,:)== i);    
            for j =  1:size(get_class_l,2)
                Corr_l_col = Corr_l(:,get_class_l(j));
                idx_rep = Corr_l_col(1);
                idx_ges = Corr_l_col(2);
                A_l = [A_l reshape(gesture_l(idx_ges,idx_rep,:),[3 1])];        
            end
            
        get_class_o = find(Corr_o(3,:)== i);    
            for j =  1:size(get_class_o,2)
                Corr_o_col = Corr_o(:,get_class_o(j));
                idx_rep = Corr_o_col(1);
                idx_ges = Corr_o_col(2);
                A_o = [A_o reshape(gesture_o(idx_ges,idx_rep,:),[3 1])];        
            end
        get_class_x = find(Corr_x(3,:)== i);    
            for j =  1:size(get_class_x,2)
                Corr_x_col = Corr_x(:,get_class_x(j));
                idx_rep = Corr_x_col(1);
                idx_ges = Corr_x_col(2);
                A_x = [A_x reshape(gesture_x(idx_ges,idx_rep,:),[3 1])];        
            end    

       figure(1)     
       hold on
       fprintf('points in class %d: %d\n',i, size(A_l,2));
       plot(A_l(1,:),A_l(2,:),'color',colorvec{i});
       
       
       figure(2)     
       hold on
       fprintf('points in class %d: %d\n',i, size(A_o,2));
       plot(A_o(1,:),A_o(2,:),'color',colorvec{i});
       
       figure(3)     
       hold on
       fprintf('points in class %d: %d\n',i, size(A_x,2));
       plot(A_x(1,:),A_x(2,:),'color',colorvec{i});
       end
       figure(1)
       plot(Y_l(:,1),Y_l(:,2),'O');
       figure(2)
       plot(Y_o(:,1),Y_o(:,2),'O');
       figure(3)
       plot(Y_x(:,1),Y_x(:,2),'O');
       fprintf('Iterations: %d\n',loop_count);
       toc
       break; 
    end
    
    
end


