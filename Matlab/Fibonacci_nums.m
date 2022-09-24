clear;clc;clf;

count = 20;
lst = [0 1];
format long e

for i = 1:count
    lst(i+2) = lst(i) + lst(i+1);
    x1(i) = lst(i+1)/lst(i);
    plot(x1,"bx")
    hold on

end

lst