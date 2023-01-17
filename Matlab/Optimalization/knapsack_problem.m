%Knapsack Problem
%{
- there are N items we can put inside a knapsack (backpack) that has capacity W

- every item k has a corresponding value ck and weight wk

- our job is to optimally select the items to take in order to maximize the value of the knapsack

- there are many variants and extensions: multidimensional, multicriteria, travelling thief problem, etc.

- if the weights are integers, the problem is solvable by the DP algorithm

- the stages correspond to the individual items (artificial time)

- systems state: xk - how much space remains in the backpack before we choose to take the kth item

- x0 = W, xN - how much space is left in the backpack after going through all the items

- decision: uk e {0,1} - don t/do take the kth item, if xk < wk, we are forced to select uk = 0

- system equation: xk+1 = xk - wkuk; k = 0,...,N - 1

- value functions for each item: gk(xk, uk) = ckuk, k = 0,...,N - 1

- value function for the last stage: gN(xN) = 0 (no value for the empty space)

JN(xN) = 0,
Jk(xk) = max ck*uk + Jk+1(xk - wk*uk), k,...,N - 1

item k  0  1 2 3
 ck    11 12 8 6
 wk     4  6 3 2
 W      8
%}
clear;clc;

N = 4; c =[11,12,8,6]; w = [4,6,3,2];
W = 8; xs = [0:W]';
J = zeros(length(xs),N+1);
mi = zeros(length(xs),N);

for k= N:-1:1
    for i=1:length(xs)
        if xs(i) < w(k)
            mi(i,k) = 0;
            J(i,k) = J(i,k+1);
        else
            J_u0 = 0 + J(i,k+1);
            J_u1 = c(k) + J(i-w(k),k+1);
            if J_u0 < J_u1
                mi(i,k) = 1; J(i,k) = J_u1;
            else
                mi(i,k) = 0; J(i,k) = J_u0;
            end
        end
    end
end