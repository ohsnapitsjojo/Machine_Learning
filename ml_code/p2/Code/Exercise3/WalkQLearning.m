function  y = WalkQLearning(s)
% Init values
alpha = 0.25;
epsilon = 0.15;
discount = 0.90;
T = 1e5;
N = 16;
S = s;

% Init Q
Q = zeros(16,4);
policy = zeros(16,1);

for t = 1:T
        % evaluate action
        tmp = rand();
        if tmp > epsilon
           % pick from greedy
           q_i = Q(s,:);
           % in case of multiple choices, pick the smallest index
           action = min(find(q_i == max(q_i)));          
        else
            % pick random action
            action = randi([1,4],1,1);   
        end

        [s_new r] = SimulateRobot(s,action);
        Q(s,action) = Q(s,action) + alpha * (r + discount * max(Q(s_new,:))- Q(s,action));
        s = s_new;
end

for i = 1:N
   q_i = Q(i,:);
   policy(i) = min(find(q_i == max(q_i))); 
end

%%
% start at state s
y = S;
for i =1:N-1
    [s_new,~] = SimulateRobot(S,policy(S));
    y = [y s_new];
    S = s_new;
end
end