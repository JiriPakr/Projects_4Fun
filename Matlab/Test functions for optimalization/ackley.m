clear;clc;
x = linspace(-5,5,100);
y = x;
z = zeros(length(x), length(y));

for i = 1:length(x)
    for ii = 1:length(y)
        z(i,ii) = ackley2D(x(i),y(ii));
    end
end

s = surf(x,y,z);
s.LineStyle = 'None';
xlabel("X")
ylabel("Y")
zlabel("Z")
title("Ackley function")

function z = ackley2D(x,y)
e = exp(1);
z = -20*exp(-0.2*sqrt(0.5*(x.^2+y.^2))) -exp(0.5*(cos(2*pi*x)+cos(2*pi*y)))+e+20;

end

