function y = WalkPolicyIteration(s)

% number of iterations
iterations = 0;
% number of states
N = 16;
% threshold for convergence
epsilon = 1e-8;
V_old = 1e9;
converged = 0;
% discount factor > 0 && < 1 
discount = 0.99;

% reward matrix
rew = [0 -1 0 -1; 0 0 -1 -1; 0 0 -1 -1; 0 0 0 0;...
       -1 -1 0 0; 0 0 0 0; 0 0 0 0; -1 1 0 0; ...
       -1 -1 0 0; 0 0 0 0; 0 0 0 0; -1 1 0 0; ...
       0 0 0 0; 0 0 -1 1; 0 0 -1 1; 0 0 0 0];

% state transition matrix
delta = [2 4 5 13; 1 3 6 14; 4 2 7 15; 3 1 8 16; ...
         6 8 1 9; 5 7 2 10; 8 6 3 11; 7 5 4 12; ...
         10 12 13 5; 9 11 14 6; 12 10 15 7; 11 9 16 8; ...
         14 16 9 1; 13 15 10 2; 16 14 11 3; 15 13 12 4];

% initialize policy
policy = ceil(rand(16,1)*4);

%% policy iteration
while(not(converged))
    % get values for each state
    Y = [];
    A = eye(N);
    for i = 1:N
        s_prime = delta(i,policy(i));
        Y = [Y; rew(i,policy(i))];
        A(i,s_prime) = A(i,s_prime) - discount;
    end
    % solve system of linear equations
    V = A\Y;
    % update policies
    for i = 1:N
       tmp = rew(i,:)' + discount * V(delta(i,:));
       tmp = find(tmp==max(tmp));
       policy(i) = tmp(1);
    end
    iterations = iterations + 1;

    % check for convergence
    if epsilon < abs(norm(V_old) - norm(V))
        V_old = V;
    else
        converged = 1;
        fprintf('Number of iterations: %d\n', iterations);
    end
end
%%
% start at state s
y = s;
for i =1:N-1
    y = [y delta(s,policy(s))];
    s = delta(s,policy(s));
end

end




