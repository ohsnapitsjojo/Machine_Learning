
load A.txt
load B.txt
load pi.txt
load A_Test_Binned.txt
load A_Train_Binned.txt
% fwd procedure
%% init
N = 12;
M = 8;
T = size(A_Train_Binned,1);
sequences = size(A_Train_Binned,2);
ll = [];

for i = 1:sequences 
    % Initialization
    o = A_Test_Binned(:,i);
    a = pi' .* B(o(1),:)';
    for t = 2:T
        % Induction
        a_tmp = zeros(N,1);
        for j = 1:N
            transition = a(:,t-1)' * A(:,j);
            a_tmp(j) = transition * B(o(t),j);
        end
        a = [a a_tmp];
    end
    p = sum(a(:,end));
    ll = [ll log(p)];
    
end
% classify log likelihood vector
class = zeros(1,sequences);
% test -> 1
class(find(ll <= -120)) = 1;
% train -> -1
class(find(ll > -120)) = -1;

ll = [ll; class];



