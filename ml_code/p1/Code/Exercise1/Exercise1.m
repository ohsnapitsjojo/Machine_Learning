function par = Exercise1(K)

load('Data.mat');

%k-fold parameter determines number of sets for training

P1 = 6;
P2 = 6;

p1_opt = 1; 
p2_opt = 1;

pos_e_sum_min  =1e12;
angle_e_sum_min = 1e12;

X = dataPartition(Input,K); %size  2 * k x n/k
Y = dataPartition(Output,K); %size 3 * k x n/k
 
%%

for p2 = 1:P2
        angle_e_sum = 0;
        
        for k = 0:K-1

            val_x = X(k*2 + 1 : k*2+1 + 1 ,:);
            val_y = Y(k*3 + 1 : k*3+1 + 2 ,:);

            train_x = X;
            train_x(k*2 + 1 : k*2+1 + 1 ,:) = [];

            train_y = Y;
            train_y(k*3 + 1 : k*3+1 + 2 ,:) = [];
        
            Z = getInputMat(train_x,p2); % p2 value

            Theta = train_y(3:3:end,:);  % 3: theta angle
            Theta = Theta';

            A_thet = (inv(Z'*Z)* Z' * Theta(:));  %train parameters

            %calc angle error   
            angle_e_p2 = sum((((val_y(3,:)' - (getInputMat(val_x,p2)* A_thet)).^2).^.5)) / size(val_y,2);
            angle_e_sum = angle_e_p2 + angle_e_sum;
            %update old error value

        end
        
        if (angle_e_sum < angle_e_sum_min)

            angle_e_sum_min = angle_e_sum;
            fprintf('update p2_opt with better value\n');
            p2_opt = p2;
        end

end
%%
for p1=1:P1
        pos_e_sum=0;
        
        for k = 0:K-1

            val_x = X(k*2 + 1 : k*2+1 + 1 ,:);
            val_y = Y(k*3 + 1 : k*3+1 + 2 ,:);

            train_x = X;
            train_x(k*2 + 1 : k*2+1 + 1 ,:) = [];

            train_y = Y;
            train_y(k*3 + 1 : k*3+1 + 2 ,:) = [];
            
            Z = getInputMat(train_x,p1); % p1 value

            pos_x = train_y(1:3:end,:);
            pos_y = train_y(2:3:end,:);

            pos_x = pos_x';
            pos_y = pos_y';

            A_x = (inv(Z'*Z)* Z' * pos_x(:));  %train parameters 
            A_y = (inv(Z'*Z)* Z' * pos_y(:));

            pos_x = val_y(1,:);
            pos_y = val_y(2,:);        

            pos_e_p1 = sum(((pos_x' -getInputMat(val_x,p1)*A_x).^2  + (pos_y'-getInputMat(val_x,p1)*A_y).^2).^0.5) / size(val_y,2);
            pos_e_sum = pos_e_sum + pos_e_p1 ;
        end
        
        %update old error value
        if (pos_e_sum < pos_e_sum_min)          
            pos_e_sum_min = pos_e_sum;
            p1_opt = p1;
            fprintf('update p1 with better p1\n');
        end  
end
        


%%
%%
fprintf('p1 opt: %d\n',p1_opt);
fprintf('p2 opt: %d\n',p2_opt);

Z_thet = getInputMat(Input,p2_opt);
Z_p1 =  getInputMat(Input,p1_opt);


A_thet =(inv(Z_thet'*Z_thet)* Z_thet' * Output(3,:)');
A_x = (inv(Z_p1'*Z_p1)* Z_p1' * Output(1,:)');  %train parameters 
A_y = (inv(Z_p1'*Z_p1)* Z_p1' * Output(2,:)');

%%

par{1} = A_x;
par{2} = A_y;
par{3} = A_thet;

%%



  
    

   

