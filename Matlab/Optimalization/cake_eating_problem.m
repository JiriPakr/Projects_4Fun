% Cake eating problem - discounted costs
%{
Discounted objective:
alpha^N*gN(xN) + sum(aplha^k*gk(xk,uk,wk),
with discount factor aplha e (0,1). DP algo can be written in alternative form:
VN(xN) = gN(xN)
Vk(xk) = min E{gk(xk,uk,wk) + aplha*Vk+1(fk(xk,uk,wk))}
Imagine you bought a large cake that you want to eat. Also, you do not want eat it all in one sitting, rather
you would like to eat it in N portions/days. However, as the days go by, the cake is getting a bit stale (it is
a bit worse each day). What is the best way to divide the cake, so that your enjoyment is maximized?

x0: Initial cake size,
N: Number of time steps (portions/days),
xk: Cake size at time k = 1,...,N,
uk: Amount of eaten cake at time k = 0,...,N - 1,
aplha : Discount factor { cake getting stale.
System model:
xk+1 = xk-uk,
utility (negative because of the minimization) just from eating cake, no uncertainty:
g(xk,uk,wk) = -2*sqrt(uk),
terminal state has no value (throw out rest of the cake):
gN(xN) = 0.
Relationship:
Vk(xk) min [-2*sqrt(uk)+aplha*Vk+1(xk-uk)]

Assingment: Compute the optimal control for x0 = 1, aplha = 0.8, N = 3.
Stochastic element: a drunk roommate comes in the evening and eats a portion lambda of the cake with probability
p, or does not eat anything with probability 1 -p. The modied problem:
VN(xN) = 0, xk+1 = xk - uk -wk(xk-uk), wk = lambda, with probability p
                                            0, with probability 1-p
%}
clear;clc;

N = 3; aplha = 0.8;
xs = linspace(0,1,101);
p = 0.3; lambda = 0.25;
g_k = @(u) -2*sqrt(u);
g_N = @(x) 0;

J = zeros(length(xs),N+1);
mi = zeros(length(xs),N);

for i=1:length(xs)
    J(i,N+1) = g_N(xs(i));
end


for k=N:-1:1
    for i=1:length(xs)
        us = 0:i-1;
        J_sub = zeros(length(us),1);
        for ii=1:length(us)
            u_cur = xs(i) - xs(i-us(ii));
            J_sub(ii) = g_k(u_cur) + aplha*((1-p)*J(i-us(ii),k+1) + p*J(ceil(lambda*(i-us(ii))),k+1));
        end
        [minval,minpos] = min(J_sub);
        J(i,k) = minval; mi(i,k) = xs(i) - xs(i-us(minpos));
    end
end