clear;clc;
x = linspace(-10,10,100);
y = x;
z = zeros(length(x), length(y));

for i = 1:length(x)
    for ii = 1:length(y)
        z(i,ii) = boothfun(x(i),y(ii));
    end
end

s = surf(x,y,z);
s.LineStyle = 'None';
xlabel("X")
ylabel("Y")
zlabel("Z")
title("Booth function")


function [z] = boothfun(x,y)
    z = ((x+2*y-7)^2) + ((2*x+y-5)^2);    
end