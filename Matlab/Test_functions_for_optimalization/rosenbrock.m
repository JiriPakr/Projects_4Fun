clear;clc;
x = linspace(-1e70,1e70,100);
y = x;
z = zeros(length(x),length(y));

for i = 1:length(x)
    for ii = 1:length(y)
        z(i,ii) = rosenbrockfun([x(i),y(ii)]);
    end
end

s = surf(x,y,z);
s.LineStyle = 'None';
xlabel("X")
ylabel("Y")
zlabel("Z")
title("Rosenbrock function")

function [y] = rosenbrockfun(x)
    d = length(x);
    sum = 0;
    for i = 1:(d-1);
        xi= x(i);
        xnext = x(i+1);
        new = 100*(xnext-xi^2)^2 + (1-xi)^2;
        sum = sum + new;
    end
    y = sum;
end