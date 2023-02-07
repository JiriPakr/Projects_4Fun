
clear;clc;

N = 10; xs = [1:5]'; us = [1:3]';
% W - pravděpodobnost přechodu x_k-x_{k-1}-U
W = zeros(5,5,3);
% u = 1 - do nothing
W(1,1,1) = 0.7; W(1,2,1) = 0.2; W(1,3,1) = 0.1;
W(2,2,1) = 0.7; W(2,3,1) = 0.2; W(2,4,1) = 0.1;
W(3,3,1) = 0.7; W(3,4,1) = 0.2; W(3,5,1) = 0.1;
W(4,4,1) = 0.7; W(4,5,1) = 0.3; W(5,5,1) = 1;
% u = 2 - repair
W(2,1,2) = 0.9; W(2,2,2) = 0.1; 
W(3,2,2) = 0.9; W(3,3,2) = 0.1; 
W(4,3,2) = 0.9; W(4,4,2) = 0.1; 
W(5,4,2) = 0.9; W(5,5,2) = 0.1; 
% u = 3 - buy new
W(2,1,3) = 1;
W(3,1,3) = 1;
W(4,1,3) = 1;
W(5,1,3) = 1;

g_p = [1;0.9;0.7;0.5;0];
g_a = [0;-0.4;-1];

J = zeros(5,N+1);
mu = zeros(5,N);
J = zeros(5,N+1);
J(:,N+1) = g_p;

for k=N:-1:1
    for i = 1:length(xs)
        Jsub = zeros(3,1);
        for j = 1:length(us)
            if sum(W(i,:,j)) > 0
                Jsub(j) = g_p(i) + g_a(j) + W(i,:,j)*J(:,k+1);          % expected profit
                %Jsub(j) = g_p(i) + g_a(j) + min(J(W(i,:,j)>0,k+1));    % worst case profit
               
            else
                Jsub(j) = -inf;
            end
        end
        [maxval,maxpos] = max(Jsub);
        J(i,k) = maxval; mu(i,k) = maxpos;
    end
end
J(1,1)

% simulator
n = 1000; x0 = 1;
J_sim = zeros(n,1); x_sim = zeros(n, N+1); x_sim(:,1) = x0;
for iter = 1:n
    for k = 1:N
    x_cur = x_sim(iter,k);
    u_cur = mu(x_cur,k);
    J_sim(iter) = J_sim(iter) + g_p(x_cur) + g_a(u_cur);
    w = W(x_cur,:,u_cur);
    r = rand;
    idxs = find(r < cumsum(w));
    x_sim(iter,k+1) = idxs(1);
    end
    J_sim(iter) = J_sim(iter) + g_p(x_sim(iter,k+1));
end

[mean(J_sim),min(J_sim)]