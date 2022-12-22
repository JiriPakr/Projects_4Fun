clear;clc;clf;

% prints Fibonacci numbers from 0 to count
% plots ratio between two subsequent values of the sequence
count = 20;
fib_lst = [0 1];
format long e

for i = 1:count
    fib_lst(i+2) = fib_lst(i) + fib_lst(i+1);
    x(i) = fib_lst(i+1)/fib_lst(i);
    plot(x,"b")
    hold on
    plot(x,"rx")
end

fib_lst