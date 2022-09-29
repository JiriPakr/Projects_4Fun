clear;clc;
x = linspace(-2,2,100);
y = x;
z = zeros(length(x),length(y));

for i = 1:length(x)
    for ii= 1:length(y)
        z(i,ii) = goldsteinprice(x(i),y(ii));
    end
end

s = surf(x,y,z);
s.LineStyle = 'None';
xlabel("X")
ylabel("Y")
zlabel("Z")
title("Goldstein-price function")

function [z] = goldsteinprice(x,y)
    z = (1+((x+y+1)^2)*(19-14*x+3*x^2 -14*y +6*x*y + 3*y^2))*(30+((2*x-3*y)^2)*(18-32*x+12*x^2+48*y-36*x*y+27*y^2));
end







