% Source: https://en.wikipedia.org/wiki/Rastrigin_function
clear;clc;
x = linspace(-5,5,100);
y = x;
z = zeros(length(x), length(y));

for i = 1:length(x)
    for ii = 1:length(y)
        z(i,ii) = rastriginfun([x(i),y(ii)]);
    end
end

s = surf(x,y,z);
s.LineStyle = 'None';
xlabel("X")
ylabel("Y")
zlabel("Z")
title("Rastrigin function")


function [y] = rastriginfun(x)
    n = length(x);
    y = 10*n + sum(x.^2 - 10*cos(2*pi*x));    
end