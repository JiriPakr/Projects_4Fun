clear;clc;
x = linspace(-1e4,1e4,100);
y = x;
z = zeros(length(x),length(y));

for i = 1:length(x)
    for ii = 1:length(y)
        z(i,ii) = sphere([x(i),y(ii)]);
    end
end

s = surf(x,y,z);
s.LineStyle = 'None';
xlabel("X")
ylabel("Y")
zlabel("Z")
title("Sphere function")

function y = sphere(x)
    y = sum(x.^2);
end