clear;clc;
x = linspace(-4.5,4.5,1000);
y = x;
z = zeros(length(x),length(y));

for i=1:length(x)
    for ii=1:length(y)
        z(i,ii) = bealefun(x(i),y(ii));
    end
end

s = surf(x,y,z);
s.LineStyle = 'None';
xlabel("X")
ylabel("Y")
zlabel("Z")
title("Beale function")

function [z] = bealefun(x,y)
    z = (1.5 - x + x*y)^2 + (2.25 - x + x*y.^2)^2 + (2.625 - x + x*y.^3)^2;

end